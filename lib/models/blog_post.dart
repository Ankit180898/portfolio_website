enum BlogPostType { personal, external }

enum BlogSectionType { heading, subheading, paragraph, bulletList, techTable, divider }

class BlogSection {
  final BlogSectionType type;
  final String? text;
  final List<String>? items;
  final List<List<String>>? tableRows;

  const BlogSection.heading(String t)
      : type = BlogSectionType.heading,
        text = t,
        items = null,
        tableRows = null;

  const BlogSection.subheading(String t)
      : type = BlogSectionType.subheading,
        text = t,
        items = null,
        tableRows = null;

  const BlogSection.paragraph(String t)
      : type = BlogSectionType.paragraph,
        text = t,
        items = null,
        tableRows = null;

  const BlogSection.bullets(List<String> i)
      : type = BlogSectionType.bulletList,
        text = null,
        items = i,
        tableRows = null;

  const BlogSection.table(List<List<String>> rows)
      : type = BlogSectionType.techTable,
        text = null,
        items = null,
        tableRows = rows;

  const BlogSection.divider()
      : type = BlogSectionType.divider,
        text = null,
        items = null,
        tableRows = null;
}

class BlogPost {
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String? link;
  final BlogPostType type;
  final String? readTime;
  final List<BlogSection>? sections;

  const BlogPost({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    this.link,
    this.type = BlogPostType.external,
    this.readTime,
    this.sections,
  });
}

// ── Personal posts ─────────────────────────────────────────────────────────────

final _spendifySections = const [
  BlogSection.paragraph(
    "I've always tracked my spending in a notes app — categories scrawled, totals added by hand. "
    "When I decided to build something real with Flutter, Spendify was the obvious first big project. "
    "What started as a simple income/expense logger grew into something I genuinely use every day.",
  ),
  BlogSection.heading("Why I Built It"),
  BlogSection.paragraph(
    "Most expense trackers are either too simple (basic add/delete) or too complex with paywalls "
    "on features you actually need. I wanted something in between — a clean UI, automatic data "
    "capture from SMS, and proper analytics without a subscription. Building it myself also meant "
    "I could design exactly the categories and budget flows that matched how I spend.",
  ),
  BlogSection.heading("What It Can Do"),
  BlogSection.bullets([
    "Log income and expenses with category, amount, and date — edit, delete, filter, and paginate history",
    "Voice input — say the transaction naturally and it auto-detects amount, category, and type",
    "SMS import — scans the last 30 days of UPI/bank messages, extracts transactions, lets you review before importing",
    "Budget limits — per-category weekly or monthly limits with visual alerts when you're close or over",
    "Savings goals — create goals with a name, emoji, target amount, and deadline; track progress with a progress bar",
    "Group splits — create groups, share invite codes, add split expenses, track who owes what, mark settlements",
    "Analytics — monthly income vs. expense trends, spending by category, top spending categories, powered by Syncfusion charts",
    "Insights — spending spike alerts, budget utilisation summaries, savings progress, category-level recommendations",
  ]),
  BlogSection.heading("Tech Stack"),
  BlogSection.table([
    ["Layer", "Technology"],
    ["Frontend", "Flutter + Dart"],
    ["State Management", "GetX"],
    ["Backend & Database", "Supabase"],
    ["Authentication", "Email, Google OAuth, Apple Sign-In"],
    ["Charts", "Syncfusion Flutter Charts"],
    ["Voice Input", "speech_to_text"],
    ["SMS Parsing", "flutter_sms_inbox"],
    ["Notifications", "flutter_local_notifications"],
  ]),
  BlogSection.heading("The Hardest Parts"),
  BlogSection.paragraph(
    "SMS parsing was the most tedious part. Bank messages are wildly inconsistent — HDFC, SBI, "
    "Paytm, PhonePe all phrase their alerts differently. I wrote regex patterns for dozens of "
    "formats, handled edge cases like refunds being misclassified as expenses, and built a "
    "manual-review step so nothing gets silently imported. The voice input had a similar challenge: "
    "natural language like 'spent 200 on lunch' needed reliable extraction of "
    "{amount: 200, category: food, type: expense} without dedicated NLP infrastructure.",
  ),
  BlogSection.paragraph(
    "Group splits required proper real-time sync via Supabase subscriptions. Getting balance "
    "calculations right — who owes whom after partial settlements — took more thought than expected. "
    "It's essentially a small accounting ledger, and off-by-one errors here are genuinely "
    "confusing for users.",
  ),
  BlogSection.heading("What I Learned"),
  BlogSection.bullets([
    "GetX is great for small-to-medium apps but starts feeling scattered at scale — I'd look at Riverpod for the next one",
    "Supabase row-level security needs to be designed from day one, not retrofitted after the schema is set",
    "Users don't read onboarding — build the UI to be self-explanatory from the first screen",
    "SMS permissions are among the most scrutinised on Play Store review — document your use case carefully in the listing",
  ]),
  BlogSection.divider(),
  BlogSection.paragraph(
    "Spendify is open source. If you're learning Flutter or want to see how any of the above "
    "features are implemented, the full source is on GitHub.",
  ),
];

final _bohriCupidSections = const [
  BlogSection.paragraph(
    "The Dawoodi Bohra community is tight-knit, globally distributed, and culturally very specific. "
    "Mainstream dating apps work against you when you need someone who shares the same traditions, "
    "language, and values. Bohri Cupid was built to close that gap — a dedicated space for the "
    "community, by the community.",
  ),
  BlogSection.heading("The Problem"),
  BlogSection.paragraph(
    "Community members are spread across India, the US, the UK, and East Africa. The existing "
    "options were either general dating apps (where cultural filters are limited) or informal "
    "family-network introductions. There was nothing in between — no modern, self-directed way "
    "to explore matches within the community on your own terms.",
  ),
  BlogSection.heading("Key Features"),
  BlogSection.bullets([
    "Community-specific onboarding with cultural identity fields beyond standard age and location",
    "Advanced filters — match by age, location, and Bohra-specific preferences",
    "5 free profile views per day (resets every 24 hours), unlimited with subscription",
    "Premium: see who liked you, direct messaging, and priority visibility in discovery",
    "Block and report flows to keep the space safe and accountable",
    "In-app purchases via Play Store billing for subscription management",
  ]),
  BlogSection.heading("Building for a Niche Community"),
  BlogSection.paragraph(
    "The cold start problem is worse for niche apps — every feature only delivers value "
    "when both sides of a match are on the platform. Early growth relied entirely on "
    "word-of-mouth within community WhatsApp groups and family networks. That trust made "
    "the first cohort of users very engaged, but also very vocal when something broke.",
  ),
  BlogSection.paragraph(
    "Moderation ended up being the hardest ongoing challenge. In a small, close-knit "
    "community, fake or inappropriate profiles cause real reputational damage. Building "
    "a solid report → review → action pipeline, and making the block feature genuinely "
    "prominent and easy to reach, became a priority after the first batch of user feedback.",
  ),
  BlogSection.heading("Technical Challenges"),
  BlogSection.paragraph(
    "Payment integration on Android is always painful. Play Store billing callbacks and "
    "Supabase webhooks needed careful reconciliation — a purchase can succeed on the device "
    "while the server webhook silently fails, leaving the user without their subscription. "
    "I built a manual refresh flow as a fallback and added better error messaging so users "
    "know when to contact support vs. when to just wait.",
  ),
  BlogSection.paragraph(
    "Real-time matching updates (new likes, messages) used Supabase Realtime subscriptions. "
    "The tricky part was handling reconnects gracefully on flaky mobile connections without "
    "flooding users with duplicate notifications.",
  ),
  BlogSection.heading("What I'd Do Differently"),
  BlogSection.bullets([
    "Ship a simpler v1 — just profiles and messaging. The subscription gating on day one hurt early retention",
    "Build admin moderation tooling before launch, not after the first wave of reports arrives",
    "Invest in community trust signals earlier — verified profiles and onboarding with real community endorsements",
    "Provide clearer value at the free tier so users experience the app before hitting the paywall",
  ]),
  BlogSection.divider(),
  BlogSection.paragraph(
    "Bohri Cupid is live on the Play Store. It's an ongoing project — new features and "
    "stability improvements ship regularly as the user base grows.",
  ),
];

// ── Blog posts list ────────────────────────────────────────────────────────────

final List<BlogPost> blogPosts = [
  // Personal
  BlogPost(
    title: "Building Bohri Cupid: A Dating App for the Dawoodi Bohra Community",
    description:
        "How I built a niche community dating app — from designing match flows and real-time chat to shipping on the Play Store and learning about moderation the hard way.",
    imageUrl: "",
    date: "10 MAR 2026",
    link: "https://play.google.com/store/apps/details?id=com.mycompany.bohradatingapp&hl=en_IN",
    type: BlogPostType.personal,
    readTime: "5 min read",
    sections: _bohriCupidSections,
  ),
  BlogPost(
    title: "Spendify: Building a Full-Featured Expense Tracker in Flutter",
    description:
        "How I designed and built Spendify — voice input, SMS parsing, savings goals, group splits, and Supabase on the backend. Open source.",
    imageUrl: "",
    date: "20 FEB 2026",
    link: "https://github.com/Ankit180898/spendify",
    type: BlogPostType.personal,
    readTime: "6 min read",
    sections: _spendifySections,
  ),

  // Curated external
  BlogPost(
    title: "What's New in Flutter 3.27",
    description:
        "Explore the latest enhancements in Flutter 3.27 — Impeller on Android, new Material 3 components, and major DevTools improvements.",
    imageUrl: "",
    date: "15 DEC 2024",
    link: "https://medium.com/flutter/whats-new-in-flutter-3-27-28341129570c",
    type: BlogPostType.external,
    readTime: "8 min read",
  ),
  BlogPost(
    title: "Dart 3.6: Key Features Every Flutter Developer Should Know",
    description:
        "A practical overview of Dart 3.6 — enhanced pattern matching, updated core libraries, and better null safety ergonomics.",
    imageUrl: "",
    date: "11 DEC 2024",
    link: "https://medium.com/dartlang/dart-3-6-c4a2d3e5d95",
    type: BlogPostType.external,
    readTime: "5 min read",
  ),
  BlogPost(
    title: "Building Responsive UIs with Flutter's Layout Tools",
    description:
        "Learn how to use LayoutBuilder, MediaQuery, and the responsive framework to create adaptive interfaces across all screen sizes.",
    imageUrl: "",
    date: "15 APR 2025",
    link: "https://docs.flutter.dev/ui/layout/responsive",
    type: BlogPostType.external,
    readTime: "6 min read",
  ),
  BlogPost(
    title: "State Management in 2025: GetX vs Riverpod vs Bloc",
    description:
        "An updated comparison of the most popular state management solutions in Flutter, with practical examples and benchmarks.",
    imageUrl: "",
    date: "10 APR 2025",
    link: "https://flutter.dev/docs/development/data-and-backend/state-mgmt/options",
    type: BlogPostType.external,
    readTime: "7 min read",
  ),
  BlogPost(
    title: "Flutter Web in Production: Best Practices",
    description:
        "Real-world insights on running Flutter Web in production — optimising load time, SEO considerations, and platform-specific workarounds.",
    imageUrl: "",
    date: "28 MAR 2025",
    link: "https://flutter.dev/web",
    type: BlogPostType.external,
    readTime: "5 min read",
  ),
];
