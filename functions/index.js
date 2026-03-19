const functions = require('firebase-functions');
const admin = require('firebase-admin');

exports.getBalancedProfiles = functions
  .region('us-central1')
  .https.onCall(async (data, context) => {
    // Authentication check
    const userId = context.auth?.uid;
    if (!userId) {
      throw new functions.https.HttpsError('unauthenticated', 'Authentication is required.');
    }

    // Extract parameters from the request
    const {
      preferredGender,
      lowerAge = 18,
      upperAge = 99,
      preferredCountries = [],
      excludeUsers = [],
      requestedCount = 8,
    } = data;

    // Initialize Firestore inside the handler for FlutterFlow compatibility
    const db = admin.firestore();
    const fetchStart = Date.now();
    
    try {
      // Get current user data to access their interaction history
      const currentUserDoc = await db.collection('users').doc(userId).get();
      const currentUserData = currentUserDoc.data();
      
      // Create a set of all users this person has already interacted with
      // This includes their own ID, likes, dislikes, blocks, and any additional exclusions
      const allExcludedIds = new Set([
        userId, 
        ...(currentUserData?.likes || []), 
        ...(currentUserData?.dislikes || []), 
        ...(currentUserData?.blocked || []),
        ...excludeUsers
      ].filter(Boolean));
      
      // =====================================================
      // PART 1: ADAPTIVE FETCH SIZE CALCULATION
      // =====================================================
      
      // Get the total count of active users matching gender preference
      // This is an efficient count query (1 read operation)
      const countQuery = db.collection('users')
        .where('active_acct', '==', true)
        .where('gender', '==', preferredGender);
      
      const countSnapshot = await countQuery.count().get();
      const totalActiveUsers = countSnapshot.data().count;
      
      // Calculate what percentage of profiles the user has already interacted with
      // Cap at 80% to prevent extreme fetch sizes
      const exclusionPercentage = Math.min(0.8, allExcludedIds.size / totalActiveUsers);
      
      // Calculate how many profiles we need to fetch to end up with enough after filtering
      // Formula: (requested / (1 - exclusion %)) * safety factor
      const BASE_PAGE_SIZE = 100;  // Minimum fetch size
      const ADAPTIVE_FETCH_SIZE = Math.max(
        BASE_PAGE_SIZE,
        Math.ceil(requestedCount / (1 - exclusionPercentage)) * 1.5
      );
      
      // Use this as our fetch limit in queries
      const MAX_FETCH = ADAPTIVE_FETCH_SIZE;
      
      functions.logger.info('Adaptive fetch size calculated', {
        userId,
        excludedCount: allExcludedIds.size,
        totalActiveUsers,
        exclusionPercentage,
        adaptiveFetchSize: MAX_FETCH
      });

      // =====================================================
      // PART 2: RANDOMIZATION SETUP
      // =====================================================
      
      // Generate a random sequence of numbers 1-15 for this query
      // This determines the order in which we'll query profiles by randomizer value
      const generateRandomizedSequence = () => {
        // Create array with numbers 1-15
        const sequence = Array.from({ length: 15 }, (_, i) => i + 1);
        
        // Fisher-Yates shuffle for randomization
        for (let i = sequence.length - 1; i > 0; i--) {
          const j = Math.floor(Math.random() * (i + 1));
          [sequence[i], sequence[j]] = [sequence[j], sequence[i]];
        }
        
        return sequence;
      };
      
      // Generate our randomized sequence for this query
      const randomizerSequence = generateRandomizedSequence();
      
      functions.logger.info('Randomizer sequence generated', {
        userId,
        randomizerSequence
      });

      // Setup for query execution
      const now = new Date();
      let locationFallback = false;
      const candidateProfiles = new Map();

      // Calculate birth date range based on age preferences
      const minBirthDate = admin.firestore.Timestamp.fromDate(
        new Date(now.getFullYear() - upperAge - 1, now.getMonth(), now.getDate())
      );
      const maxBirthDate = admin.firestore.Timestamp.fromDate(
        new Date(now.getFullYear() - lowerAge, now.getMonth(), now.getDate())
      );

      // Helper functions for data formatting
      const formatTimestamp = ts => ts?.toDate?.()?.toISOString() || null;
      const formatLatLng = loc => (loc?._latitude !== undefined && loc?._longitude !== undefined)
        ? { lat: loc._latitude, lng: loc._longitude }
        : null;

      const formatProfile = doc => {
        const user = doc.data();
        return {
          id: doc.id,
          ...user,
          birthDate: formatTimestamp(user.birthDate),
          created_time: formatTimestamp(user.created_time),
          last_visit: formatTimestamp(user.last_visit),
          creditRefreshDate: formatTimestamp(user.creditRefreshDate),
          lat_long: formatLatLng(user.lat_long),
        };
      };

      // =====================================================
      // PART 3: PROFILE FETCHING WITH RANDOMIZATION
      // =====================================================
      
      // Core fetch function - queries profiles in chunks based on randomizer sequence
      const fetchProfiles = async (countryFilter = [], excludeCountries = [], isPreferred = true) => {
        // Process the randomizer values in chunks of 5 (Firestore 'in' operator limit is 10)
        // This gives us 3 chunks covering all 15 randomizer values
        for (let chunkStart = 0; chunkStart < randomizerSequence.length; chunkStart += 5) {
          // Get the current chunk of randomizer values (5 values per chunk)
          const randomizerChunk = randomizerSequence.slice(chunkStart, chunkStart + 5);
          
          // Skip this chunk if we already have enough profiles
          // We aim for 2x the requested count to have a good buffer
          if (candidateProfiles.size >= requestedCount * 2) {
            break;
          }
          
          // Build the base query with randomizer chunk filter
          // This is critical - we're only fetching profiles with specific randomizer values
          let baseQuery = db.collection('users')
            .where('active_acct', '==', true)
            .where('birthDate', '<=', maxBirthDate)
            .where('birthDate', '>=', minBirthDate)
            .where('randomizer', 'in', randomizerChunk);

          if (preferredGender) {
            baseQuery = baseQuery.where('gender', '==', preferredGender);
          }

          // Within each randomizer chunk, sort by last_visit for recency
          baseQuery = baseQuery.orderBy('last_visit', 'desc').limit(MAX_FETCH);

          // Handle country filtering
          if (countryFilter.length > 0) {
            // Firestore 'in' operator can only handle 10 values, so chunk countries
            const locationChunks = [];
            for (let i = 0; i < countryFilter.length; i += 10) {
              locationChunks.push(countryFilter.slice(i, i + 10));
            }

            // Process each location chunk
            for (const locationChunk of locationChunks) {
              const query = baseQuery.where('location', 'in', locationChunk);
              const snap = await query.get();
              
              functions.logger.info(`Fetched profiles for chunk ${chunkStart/5 + 1}/3 with location filter`, {
                randomizerChunk,
                locationChunk,
                resultCount: snap.size
              });
              
              // Process the results, filtering out already-interacted profiles
              snap.forEach(doc => {
                const location = doc.get('location');
                if (!allExcludedIds.has(doc.id) && !excludeCountries.includes(location) && !candidateProfiles.has(doc.id)) {
                  // Track the sequence position for sorting
                  const randomizerValue = doc.get('randomizer') || 1;
                  const sequencePosition = randomizerSequence.indexOf(randomizerValue);
                  
                  candidateProfiles.set(doc.id, {
                    doc,
                    metadata: {
                      location,
                      lastVisit: doc.get('last_visit')?.toMillis() || 0,
                      isPreferred,
                      randomizer: randomizerValue,
                      sequencePosition
                    },
                  });
                }
              });
              
              // Stop if we have enough profiles
              if (candidateProfiles.size >= requestedCount * 2) {
                break;
              }
            }
          } else {
            // No country filter - simpler query
            const snap = await baseQuery.get();
            
            functions.logger.info(`Fetched profiles for chunk ${chunkStart/5 + 1}/3 without location filter`, {
              randomizerChunk,
              resultCount: snap.size
            });
            
            // Process the results, filtering out already-interacted profiles
            snap.forEach(doc => {
              const location = doc.get('location');
              if (!allExcludedIds.has(doc.id) && !excludeCountries.includes(location) && !candidateProfiles.has(doc.id)) {
                // Track the sequence position for sorting
                const randomizerValue = doc.get('randomizer') || 1;
                const sequencePosition = randomizerSequence.indexOf(randomizerValue);
                
                candidateProfiles.set(doc.id, {
                  doc,
                  metadata: {
                    location,
                    lastVisit: doc.get('last_visit')?.toMillis() || 0,
                    isPreferred,
                    randomizer: randomizerValue,
                    sequencePosition
                  },
                });
              }
            });
            
            // Stop if we have enough profiles
            if (candidateProfiles.size >= requestedCount * 2) {
              break;
            }
          }
        }
      };

      // =====================================================
      // PART 4: QUERY EXECUTION STRATEGY
      // =====================================================
      
      // First try preferred countries if specified
      if (preferredCountries.length > 0) {
        await fetchProfiles(preferredCountries, [], true);
        
        // If we don't have enough profiles, fall back to global search
        // excluding the preferred countries (to avoid duplicates)
        if (candidateProfiles.size < requestedCount) {
          locationFallback = true;
          await fetchProfiles([], preferredCountries, false);
        }
      } else {
        // No preferred countries - just do global search
        await fetchProfiles([], [], true);
      }

      // =====================================================
      // PART 5: SORTING AND FINAL SELECTION
      // =====================================================
      
      // Multi-tier sorting:
      // 1. Preferred locations first
      // 2. Within each preference group, sort by randomizer sequence position
      // 3. Within the same randomizer value, sort by recency
      const sorted = Array.from(candidateProfiles.values()).sort((a, b) => {
        // First sort by preference
        if (a.metadata.isPreferred && !b.metadata.isPreferred) return -1;
        if (!a.metadata.isPreferred && b.metadata.isPreferred) return 1;
        
        // Then sort by randomizer sequence position
        if (a.metadata.sequencePosition < b.metadata.sequencePosition) return -1;
        if (a.metadata.sequencePosition > b.metadata.sequencePosition) return 1;
        
        // Finally sort by recency
        return b.metadata.lastVisit - a.metadata.lastVisit;
      });

      // Take only the requested number of profiles
      const profiles = sorted.slice(0, requestedCount).map(p => formatProfile(p.doc));

      // Track distribution of randomizer values for analysis
      const randomizerDistribution = {};
      profiles.forEach(p => {
        const randomizerValue = p.randomizer || 1;
        randomizerDistribution[randomizerValue] = (randomizerDistribution[randomizerValue] || 0) + 1;
      });

      functions.logger.info('getBalancedProfiles completed', {
        userId,
        durationMs: Date.now() - startTime,
        returned: result.length,
        requested: requestedCount,
        usedFallback,
        excludedCount: excludedIds.size
      });

      return {
        profiles: result,
        locationFallback: usedFallback,
      };

    } catch (error) {
      functions.logger.error('getBalancedProfiles failed', {
        userId,
        error: error.message,
        stack: error.stack
      });

      throw new functions.https.HttpsError('internal', 'Failed to fetch profiles');
    }
  }); 