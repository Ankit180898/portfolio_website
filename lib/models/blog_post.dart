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
    title: "What's New in Flutter 3.22",
    description:
        "Explore the latest enhancements in Flutter 3.22, including faster compilation, better DevTools integration, and improved Material 3 support.",
    imageUrl: "assets/images/blog/flutter_3_22.jpg",
    date: "02 MAY 2025",
    link: "https://medium.com/flutter/whats-new-in-flutter-3-22-may-2025-edition-abc123", // Replace with actual link
  ),
  BlogPost(
    title: "Mastering Impeller: Flutter’s New Graphics Engine",
    description:
        "Dive deep into Impeller, Flutter’s new renderer that improves animation smoothness and GPU performance.",
    imageUrl: "assets/images/blog/impeller.jpg",
    date: "28 APR 2025",
    link: "https://medium.com/flutter/introducing-impeller-flutters-next-gen-renderer-xyz456", // Replace with actual link
  ),
  BlogPost(
    title: "Flutter for Web in 2025: How Far Have We Come?",
    description:
        "A comprehensive analysis of Flutter Web's performance improvements, use cases, and production readiness in 2025.",
    imageUrl: "assets/images/blog/flutter_web.jpg",
    date: "20 APR 2025",
    link: "https://flutter.dev/web", // Official Flutter Web page
  ),
  BlogPost(
    title: "Building AI-powered Chatbots in Flutter",
    description:
        "Learn how to integrate AI models like Gemini or ChatGPT with Flutter to build next-gen chat experiences.",
    imageUrl: "assets/images/blog/ai_chatbot.jpg",
    date: "10 APR 2025",
    link: "https://medium.com/flutter/building-ai-chatbots-with-flutter-8a123abc", // Replace with actual link
  ),
  BlogPost(
    title: "Flutter DevTools: Productivity Tips You Didn't Know",
    description:
        "Uncover lesser-known features of Flutter DevTools that can boost your debugging and profiling workflow.",
    imageUrl: "assets/images/blog/devtools.jpg",
    date: "01 APR 2025",
    link: "https://docs.flutter.dev/tools/devtools", // Official docs
  ),
];

