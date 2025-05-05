class BlogPost {
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String? link;

  BlogPost({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    this.link,
  });
}

final List<BlogPost> blogPosts = [
  BlogPost(
    title: "What's New in Flutter 3.19",
    description:
        "Explore the latest enhancements in Flutter 3.19, including performance improvements, new Material 3 widgets, and DevTools updates.",
    imageUrl:
        "https://miro.medium.com/v2/resize:fit:1400/1*MqYPYKdNBiID0mZ-zyE-mA.png",
    date: "05 MAY 2025",
    link: "https://medium.com/flutter/whats-new-in-flutter-3-19-58b1aae242d2",
  ),
  BlogPost(
    title: "Getting Started with Dart 3.3: Key Features for Flutter Developers",
    description:
        "A practical guide to Dart 3.3's new features including enhanced pattern matching, improved type system, and performance optimizations.",
    imageUrl: "https://avatars.githubusercontent.com/u/1609975?s=200&v=4",
    date: "20 APR 2025",
    link: "https://dart.dev/guides/whats-new",
  ),
  BlogPost(
    title: "Building Responsive UIs with Flutter's Latest Layout Tools",
    description:
        "Learn how to leverage LayoutBuilder, MediaQuery, and the new responsive framework to create adaptive interfaces across all screen sizes.",
    imageUrl:
        "https://miro.medium.com/v2/resize:fit:1400/1*MqYPYKdNBiID0mZ-zyE-mA.png",
    date: "15 APR 2025",
    link: "https://docs.flutter.dev/ui/layout/responsive",
  ),
  BlogPost(
    title: "State Management in 2025: Riverpod vs Bloc vs Redux",
    description:
        "An updated comparison of the most popular state management solutions in Flutter, with practical examples and performance benchmarks.",
    imageUrl:
        "https://miro.medium.com/v2/resize:fit:1400/1*MqYPYKdNBiID0mZ-zyE-mA.png",
    date: "10 APR 2025",
    link:
        "https://flutter.dev/docs/development/data-and-backend/state-mgmt/options",
  ),
  BlogPost(
    title: "Flutter Web in Production: Case Studies and Best Practices",
    description:
        "Real-world examples of companies using Flutter Web in production, with insights on optimization techniques and performance considerations.",
    imageUrl:
        "https://miro.medium.com/v2/resize:fit:1400/1*MqYPYKdNBiID0mZ-zyE-mA.png",
    date: "28 MAR 2025",
    link: "https://flutter.dev/web",
  ),
  BlogPost(
    title: "Testing Flutter Applications: A Complete Guide for 2025",
    description:
        "A comprehensive overview of testing strategies for Flutter apps, including unit, widget, and integration testing with the latest tools.",
    imageUrl:
        "https://miro.medium.com/v2/resize:fit:1400/1*MqYPYKdNBiID0mZ-zyE-mA.png",
    date: "20 MAR 2025",
    link: "https://docs.flutter.dev/testing",
  ),
];
