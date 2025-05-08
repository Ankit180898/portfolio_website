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
        "Empowering women's voices with a podcasting platform. Live on Play Store.",
    imageUrl: "2.png",
    liveLink: "https://play.google.com/store/apps/details?id=com.sheqonomi",
    technologies: ["Flutter", "Firebase", "Playstore"],
    type: ProjectType.app,
  ),
  Project(
    title: "Home|Home 4IM",
    description:
        "A social networking app to support individuals transitioning to life in a new country.",
    imageUrl: "3.png",
    liveLink:
        "https://play.google.com/store/apps/details?id=com.home4im&hl=en_US",
    technologies: ["Flutter", "Firebase", "Playstore"],
    type: ProjectType.app,
  ),
  Project(
    title: "MonkeyType Clone",
    description:
        "Level up your typing speed. Real-time accuracy, customizable tests.",
    imageUrl: "12.webp",
    liveLink: "https://monkeytypes.netlify.app/",
    githubLink: "https://github.com/Ankit180898?tab=repositories",
    technologies: ["Flutter", "Dart", "Netlify"],
    type: ProjectType.web,
  ),
  Project(
    title: "Home|Website",
    description:
        "Connecting individuals in new countries. Discover a welcoming community online.",
    imageUrl: "6.webp",
    liveLink: "https://home4im.vercel.app/",
    technologies: ["Flutter", "Firebase", "Vercel"],
    type: ProjectType.web,
  ),
  Project(
    title: "Spendify",
    description:
        "Master your finances. Track expenses with ease using Supabase and Flutter.",
    imageUrl: "Spendify.png",
    githubLink: "https://github.com/Ankit180898/spendify",
    technologies: ["Flutter", "Supabase"],
    type: ProjectType.app,
  ),
  Project(
    title: "BlingBill",
    description:
        "Jewelers, manage your inventory and billing without the stress.",
    imageUrl: "11.webp",
    githubLink: "https://github.com/Ankit180898/blingbill",
    technologies: ["Flutter", "GetX", "Pdf"],
    type: ProjectType.app,
  ),
  Project(
    title: "Vision AI",
    description:
        " Unleash your imagination. Turn text into stunning AI-generated art.",
    imageUrl: "10.webp",
    githubLink: "https://github.com/Ankit180898/text_to_image",
    technologies: ["Flutter", "GetX", "Hugging Face"],
    type: ProjectType.app,
  ),

  Project(
    title: "Flight Tracker",
    description: "Track flights. Know the status. Get it done.",
    imageUrl: "10.webp",
    githubLink: "https://github.com/Ankit180898/SkyPulse",
    technologies: ["Flutter", "GetX", "Supabase", "Aviation API"],
    type: ProjectType.app,
  ),
  Project(
    title: "Mediflow",
    description:
        "Your personal health assistant. Manage appointments, understand symptoms.",
    imageUrl: "10.webp",
    githubLink: "https://github.com/Ankit180898/mediflow",
    technologies: ["Flutter", "GetX", "ChatGPT API"],
    type: ProjectType.app,
  ),

  Project(
    title: "BlogD",
    description: "A simple blogging app. Share your stories.",
    imageUrl: "7.png",
    githubLink: "https://github.com/Ankit180898/blog_app",
    technologies: ["Flutter", "Supabase"],
    type: ProjectType.app,
  ),
  Project(
    title: "FlutterStack",
    description:
        "The best Flutter resources, all in one place. Community-driven.",
    imageUrl: "FlutterStack.png",
    githubLink: "https://github.com/Ankit180898/flutter_resource_gallery",
    liveLink: "https://flutterstack.netlify.app/",
    technologies: ["Flutter", "Supabase", "Netlify"],
    type: ProjectType.web,
  ),
  Project(
    title: "Stock Search",
    description: "Make smart investments. Real-time stock data.",
    imageUrl: "9.webp",
    githubLink: "https://github.com/Ankit180898/stock_search",
    technologies: ["Flutter", "GetX"],
    type: ProjectType.app,
  ),
  Project(
    title: "News App",
    description: "Get the latest news. Built with Flutter and GetX.",
    imageUrl: "8.webp",
    githubLink: "https://github.com/Ankit180898/news_app",
    technologies: ["Flutter", "GetX", "NewsAPI"],
    type: ProjectType.app,
  ),
  Project(
    title: "Artwork Images",
    description: "Discover art from the best artists.",
    imageUrl: "Artworks_Images.png",
    githubLink: "https://github.com/yourusername/ayehigh",
    liveLink: "https://artwork-images.netlify.app/",
    technologies: ["Flutter", "Netlify"],
    type: ProjectType.web,
  ),
];
