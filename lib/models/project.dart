enum ProjectType { app, web, design }

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final String? liveLink;
  final String? githubLink;
  final List<String> technologies;
  final ProjectType type;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.liveLink,
    this.githubLink,
    required this.technologies,
    required this.type,
  });

  // Factory method to create a Project from JSON
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      liveLink: json['liveLink'] as String?,
      githubLink: json['githubLink'] as String?,
      technologies: List<String>.from(json['technologies'] as List),
      type: _getProjectTypeFromString(json['type'] as String),
    );
  }

  // Helper method to convert string to ProjectType enum
  static ProjectType _getProjectTypeFromString(String type) {
    switch (type.toLowerCase()) {
      case 'app':
        return ProjectType.app;
      case 'web':
        return ProjectType.web;
      case 'design':
        return ProjectType.design;
      default:
        return ProjectType.web;
    }
  }

  // Convert Project to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'liveLink': liveLink,
      'githubLink': githubLink,
      'technologies': technologies,
      'type': type.toString().split('.').last,
    };
  }
}

// Sample projects data
final List<Project> allProjects = [
  Project(
    title: "Sheqonomi",
    description:
        "Discover the difference when millennials and GENZ women curate content that will impact billions. Our world has certainly changed.",
    imageUrl: "2.png",
    liveLink: "https://play.google.com/store/apps/details?id=com.sheqonomi",
    technologies: ["Flutter", "Firebase", "Playstore"],
    type: ProjectType.app,
  ),
  Project(
    title: "Home|Home 4IM",
    description:
        "Home is a social networking app designed to support and connect individuals starting their new life in a foreign country. Our mission is to create a welcoming community where users can share experiences, ask questions, and find helpful resources.",
    imageUrl: "3.png",
    liveLink:
        "https://play.google.com/store/apps/details?id=com.home4im&hl=en_US",
    technologies: ["Flutter", "Firebase", "Playstore"],
    type: ProjectType.app,
  ),
  Project(
    title: "MonkeyType Clone",
    description:
        "A typing speed tester inspired by Monkeytype, built using Flutter Web. It features a dark theme, real-time typing accuracy with color-coded feedback, customizable test modes (words, punctuation, quotes), and a detailed results summary. The app aims to help users improve their typing speed and accuracy in an engaging way.",
    imageUrl: "12.webp",
    liveLink: "https://monkeytypes.netlify.app/",
    githubLink: "https://github.com/Ankit180898?tab=repositories",
    technologies: ["Flutter", "Dart", "Netlify"],
    type: ProjectType.web,
  ),
  Project(
    title: "Home|Website",
    description:
        "Home is a social networking app designed to support and connect individuals starting their new life in a foreign country. Our mission is to create a welcoming community where users can share experiences, ask questions, and find helpful resources.",
    imageUrl: "6.webp",
    liveLink: "https://home4im.vercel.app/",
    technologies: ["Flutter", "Firebase", "Vercel"],
    type: ProjectType.web,
  ),
  Project(
    title: "Vision AI",
    description:
        "a mobile app that transforms text prompts into AI-generated images.",
    imageUrl: "10.webp",
    githubLink: "https://github.com/Ankit180898/text_to_image",
    technologies: ["Flutter", "GetX", "Hugging Face"],
    type: ProjectType.app,
  ),
  Project(
    title: "BlingBill",
    description:
        "BlingBill is a sleek jewelry inventory and billing app that helps jewelers manage products, track sales, and generate invoices effortlessly.",
    imageUrl: "11.webp",
    githubLink: "https://github.com/Ankit180898/blingbill",
    technologies: ["Flutter", "GetX", "Pdf"],
    type: ProjectType.app,
  ),
  Project(
    title: "Spendify",
    description:
        "An Expense Tracker App to manage your daily expenses. Build using Supabase and Flutter.",
    imageUrl: "Spendify.png",
    githubLink: "https://github.com/Ankit180898/spendify",
    technologies: ["Flutter", "Supabase"],
    type: ProjectType.app,
  ),
  Project(
    title: "BlogD",
    description: "BlogD is a blogging app",
    imageUrl: "7.png",
    githubLink: "https://github.com/Ankit180898/blog_app",
    technologies: ["Flutter", "Supabase"],
    type: ProjectType.app,
  ),
  Project(
    title: "FlutterStack",
    description:
        "Curated resources for Flutter Developers. A community-driven platform.",
    imageUrl: "FlutterStack.png",
    githubLink: "https://github.com/Ankit180898/flutter_resource_gallery",
    liveLink: "https://flutterstack.netlify.app/",
    technologies: ["Flutter", "Supabase", "Netlify"],
    type: ProjectType.web,
  ),
  Project(
    title: "Stock Search",
    description:
        "A Flutter application that provides stock price and financial information, helping users make informed trading and investment decisions.",
    imageUrl: "9.webp",
    githubLink: "https://github.com/Ankit180898/stock_search",
    technologies: ["Flutter", "GetX"],
    type: ProjectType.app,
  ),
  Project(
    title: "News App",
    description:
        "The News App is a Flutter-based application that fetches and displays the latest news articles using NewsAPI. The app follows the MVVM architecture with GetX for state management",
    imageUrl: "8.webp",
    githubLink: "https://github.com/Ankit180898/news_app",
    technologies: ["Flutter", "GetX", "NewsAPI"],
    type: ProjectType.app,
  ),
  Project(
    title: "Artwork Images",
    description:
        "Artwork Images is a platform where you can find images of some of best artists.",
    imageUrl: "Artworks_Images.png",
    githubLink: "https://github.com/yourusername/ayehigh",
    liveLink: "https://artwork-images.netlify.app/",
    technologies: ["Flutter", "Netlify"],
    type: ProjectType.web,
  ),
];
