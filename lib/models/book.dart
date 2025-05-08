class Book {
  final String title;
  final String author;
  String? imageUrl;
  final String date;
  final double rating;
  final int readTimeMinutes;
  final List<TldrPoint> tldrPoints;
  final String? notes;
  final String? bookLink;
  final String? isbn; // Added ISBN field

  Book({
    required this.title,
    required this.author,
    this.imageUrl,
    required this.date,
    required this.rating,
    this.readTimeMinutes = 35,
    required this.tldrPoints,
    this.notes,
    this.bookLink,
    this.isbn,
  });

  String getImageUrl() {
    // Use imageUrl if provided
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return imageUrl!;
    }

    // Use OpenLibrary only for valid ISBN-10 or ISBN-13
    final isbnPattern = RegExp(r'^\d{9}[\dXx]$|^\d{13}$');
    if (isbn != null && isbnPattern.hasMatch(isbn!)) {
      return 'https://covers.openlibrary.org/b/isbn/$isbn-L.jpg?default=false';
    }

    // Fallback to a generic cover image using author and title
    String formattedTitle = title.toLowerCase().replaceAll(' ', '+');
    String formattedAuthor = author.toLowerCase().replaceAll(' ', '+');
    return 'https://via.placeholder.com/400x600.png?text=$formattedAuthor+-+$formattedTitle';
  }
}

class TldrPoint {
  final String emoji;
  final String text;

  TldrPoint({required this.emoji, required this.text});
}

// Example book list - with fixed image handling and corrected ISBNs
final List<Book> books = [
  Book(
    title: "Feel Good Productivity",
    author: "Ali Abdaal",
    date: "31 OCT 2023",
    rating: 5.0,
    readTimeMinutes: 35,
    isbn: "9781847943736", // Corrected ISBN
    tldrPoints: [
      TldrPoint(
        emoji: "🚀",
        text:
            "Feel good to get things done – Happiness isn't the result of success—it's the fuel for it.",
      ),
      TldrPoint(emoji: "⚡", text: "Part 1: Energise"),
      TldrPoint(
        emoji: "🎮",
        text:
            "Play your way to progress – Add adventure, side quests, and a sprinkle of fun to daily tasks. Work doesn't have to suck.",
      ),
    ],
    notes: "A great book on how to be productive without burning out.",
    bookLink:
        "https://www.amazon.co.uk/Feel-Good-Productivity-Achieve-More-Matters/dp/184794373X",
  ),
  Book(
    title: "The Creative Act",
    author: "Rick Rubin",
    date: "03 DEC 2023",
    rating: 5.0,
    readTimeMinutes: 40,
    isbn: "9781838858636", // Added full ISBN-13
    tldrPoints: [
      TldrPoint(
        emoji: "🎨",
        text:
            "Creativity is a practice, not a talent – Everyone can create if they develop the right habits.",
      ),
      TldrPoint(
        emoji: "⏱️",
        text:
            "Make space for creativity – Remove distractions and create time for inspiration to strike.",
      ),
      TldrPoint(
        emoji: "🔄",
        text:
            "Embrace the iterative process – Great work emerges through cycles of creation, reflection, and refinement.",
      ),
    ],
    notes: "Insights on creativity and the artistic process.",
    bookLink: "https://www.amazon.co.uk/Creative-Act-Way-Being/dp/1838858636",
  ),
  Book(
    title: "Steve Jobs",
    author: "Walter Isaacson",
    date: "05 AUG 2023",
    rating: 5.0,
    readTimeMinutes: 60,
    isbn: "9781451648539", // Corrected to full ISBN-13
    tldrPoints: [
      TldrPoint(
        emoji: "💡",
        text:
            "Think different – Don't just improve existing products; reimagine them completely.",
      ),
      TldrPoint(
        emoji: "🎯",
        text:
            "Focus is about saying no – Eliminate the unimportant to focus on what truly matters.",
      ),
      TldrPoint(
        emoji: "✨",
        text:
            "Details matter – Obsess over the smallest aspects of your product, even the parts users won't see.",
      ),
    ],
    notes: "The definitive biography of Apple's visionary founder.",
    bookLink:
        "https://www.amazon.co.uk/Steve-Jobs-Walter-Isaacson/dp/1451648537",
  ),
  Book(
    title: "Atomic Habits",
    author: "James Clear",
    date: "15 JAN 2024",
    rating: 4.5,
    readTimeMinutes: 45,
    isbn: "9781847941831", // Corrected to full ISBN-13
    tldrPoints: [
      TldrPoint(
        emoji: "🧠",
        text:
            "1% better every day – Small improvements compound into remarkable results over time.",
      ),
      TldrPoint(
        emoji: "🧩",
        text:
            "Four laws of behavior change – Make it obvious, attractive, easy, and satisfying to build better habits.",
      ),
      TldrPoint(
        emoji: "👤",
        text:
            "Identity-based habits – Focus on who you want to become, not just what you want to achieve.",
      ),
      TldrPoint(
        emoji: "🔁",
        text:
            "Habit stacking – Link a new habit to an existing one to make it easier to remember and execute.",
      ),
    ],
    notes:
        "A practical guide to building good habits and breaking bad ones through incremental changes. The book offers a framework that has helped me transform my daily routines and productivity systems.",
    bookLink:
        "https://www.amazon.co.uk/Atomic-Habits-Proven-Build-Break/dp/1847941834",
  ),
  Book(
    title: "Staff Engineer",
    author: "Will Larson",
    date: "22 FEB 2024",
    rating: 5.0,
    readTimeMinutes: 50,
    isbn: "B08RMSHYGG", // Keeping ASIN as it's an e-book
    tldrPoints: [
      TldrPoint(
        emoji: "🧰",
        text:
            "Four Staff archetypes – Tech Lead, Architect, Solver, and Right Hand operate differently but all drive technical direction.",
      ),
      TldrPoint(
        emoji: "📈",
        text:
            "Getting the title – Promotion requires consistent impact, sponsorship, and proof you're already operating at the next level.",
      ),
      TldrPoint(
        emoji: "🗺️",
        text:
            "Staff projects – Work on high-leverage, company-aligned projects that tap into your unique skills.",
      ),
      TldrPoint(
        emoji: "🔍",
        text:
            "Technical vision – Lead by writing effective technical documents that tell compelling stories about the future.",
      ),
    ],
    notes:
        "An essential guide for senior engineers looking to advance their career beyond the management track. The book provides practical advice for navigating the Staff+ engineer role and its challenges.",
    bookLink:
        "https://www.amazon.co.uk/Staff-Engineer-Leadership-beyond-management-ebook/dp/B08RMSHYGG",
  ),
  Book(
    title: "Think Again",
    author: "Adam Grant",
    date: "05 MAR 2024",
    rating: 4.5,
    readTimeMinutes: 40,
    isbn: "9780753553886", // Corrected to full ISBN-13
    tldrPoints: [
      TldrPoint(
        emoji: "🤔",
        text:
            "Rethink thinking – The skill of rethinking and unlearning is more valuable than raw intelligence.",
      ),
      TldrPoint(
        emoji: "🧠",
        text:
            "Three modes – Avoid preacher (defending beliefs), prosecutor (attacking others' thinking), and politician (pleasing audience) mindsets.",
      ),
      TldrPoint(
        emoji: "🗣️",
        text:
            "Better disagreements – Find common ground, ask questions, and stay curious rather than combative.",
      ),
      TldrPoint(
        emoji: "🔄",
        text:
            "Joy of being wrong – Embrace intellectual humility and learn to revise your views when evidence demands it.",
      ),
    ],
    notes:
        "Adam Grant explores the value of rethinking and unlearning in a rapidly changing world. The book challenged many of my assumptions about how I approach problems and make decisions.",
    bookLink:
        "https://www.amazon.co.uk/Think-Again-Power-Knowing-What/dp/0753553880",
  ),
  Book(
    title: "The Psychology of Money",
    author: "Morgan Housel",
    date: "12 APR 2024",
    rating: 4.5,
    readTimeMinutes: 38,
    isbn: "9780857197689", // Corrected to full ISBN-13
    tldrPoints: [
      TldrPoint(
        emoji: "💰",
        text:
            "Financial decisions are personal – Driven by your unique view of the world, not pure rationality.",
      ),
      TldrPoint(
        emoji: "⏳",
        text:
            "Compounding is everything – The most powerful force in finance is the magic of consistent returns over time.",
      ),
      TldrPoint(
        emoji: "🛡️",
        text:
            "Room for error – Building financial buffers against inevitable mistakes and unexpected events is crucial.",
      ),
      TldrPoint(
        emoji: "😌",
        text:
            "Enough is freedom – Reasonable financial goals and knowing when to stop provide more wealth than chasing infinite growth.",
      ),
    ],
    notes:
        "A fascinating exploration of the psychological aspects of money management, told through engaging stories. The book helped me understand why people make irrational financial decisions despite knowing better.",
    bookLink:
        "https://www.amazon.com/Psychology-Money-Timeless-lessons-happiness/dp/0857197681",
  ),
  Book(
    title: "Designing Data-Intensive Applications",
    author: "Martin Kleppmann",
    date: "10 MAY 2024",
    rating: 5.0,
    readTimeMinutes: 65,
    isbn: "9781449373320", // Corrected to full ISBN-13
    tldrPoints: [
      TldrPoint(
        emoji: "🗄️",
        text:
            "Database fundamentals – Deep dive into how database engines store and retrieve data efficiently.",
      ),
      TldrPoint(
        emoji: "🔄",
        text:
            "Replication strategies – Synchronous vs asynchronous approaches each have distinct trade-offs for reliability and performance.",
      ),
      TldrPoint(
        emoji: "📊",
        text:
            "Partitioning data – Techniques for splitting datasets across machines to handle scale and reduce bottlenecks.",
      ),
      TldrPoint(
        emoji: "⚡",
        text:
            "Consistency guarantees – Understanding the spectrum from eventual to strict consistency helps make better architecture decisions.",
      ),
    ],
    notes:
        "The definitive guide to designing scalable and reliable systems. This book has become my go-to reference when designing architecture for data-heavy applications.",
    bookLink:
        "https://www.amazon.co.uk/Designing-Data-Intensive-Applications-Reliable-Maintainable/dp/1449373321",
  ),
  Book(
    title: "Think Like a Software Engineering Manager",
    author: "Akanksha Gupta",
    date: "22 JUN 2024",
    rating: 4.0,
    readTimeMinutes: 42,
    isbn: "9781804611753", // Corrected ISBN
    tldrPoints: [
      TldrPoint(
        emoji: "👥",
        text:
            "People management – Technical leadership requires both technical expertise and strong interpersonal skills.",
      ),
      TldrPoint(
        emoji: "🌱",
        text:
            "Team growth – Successful engineering managers focus on developing their team members' careers and abilities.",
      ),
      TldrPoint(
        emoji: "🔄",
        text:
            "Delivery focus – Balancing technical excellence with business needs is a core skill for engineering leaders.",
      ),
      TldrPoint(
        emoji: "🤝",
        text:
            "Cross-functional collaboration – Building relationships across teams is essential for organizational success.",
      ),
    ],
    notes:
        "A practical guide for developers transitioning to management roles. The book offers actionable advice on building and leading high-performing engineering teams.",
    bookLink:
        "https://www.amazon.co.uk/Think-Like-Software-Engineering-Manager-ebook/dp/B0BVSXB5W7",
  ),
  Book(
    title: "Lead Developer Career Guide",
    author: "Shelley Benhoff",
    date: "18 NOV 2024",
    rating: 4.5,
    readTimeMinutes: 38,
    isbn: "9781092426046", // Corrected to full ISBN-13
    tldrPoints: [
      TldrPoint(
        emoji: "🧠",
        text:
            "Leadership mindset – Taking responsibility for team success requires a fundamental shift in thinking.",
      ),
      TldrPoint(
        emoji: "🗣️",
        text:
            "Communication skills – Effective communication is key to establishing trust and building high-performing teams.",
      ),
      TldrPoint(
        emoji: "💼",
        text:
            "Career path strategy – Understand the skills and mindset shifts necessary to progress from developer to lead.",
      ),
    ],
    notes:
        "This book provides essential advice for senior developers looking to transition into leadership positions. The practical steps for developing leadership skills were particularly useful.",
    bookLink:
        "https://www.amazon.co.uk/Lead-Developer-Career-Guide/dp/1092426042",
  ),
];
