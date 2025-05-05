class Resource {
  final String title;
  final String? emoji;
  final String? url;
  final ResourceType type;

  Resource({required this.title, this.emoji, this.url, required this.type});
}

enum ResourceType { category, item }

// Resource categories
final List<Resource> resourceCategories = [
  Resource(title: "Flutter UI Kits", emoji: "🎨", type: ResourceType.category),
  Resource(
    title: "Animations & Effects",
    emoji: "🎞️",
    type: ResourceType.category,
  ),
  Resource(title: "State Management", emoji: "🧠", type: ResourceType.category),
  Resource(
    title: "Firebase Integration",
    emoji: "🔥",
    type: ResourceType.category,
  ),
  Resource(
    title: "Open Source Projects",
    emoji: "📂",
    type: ResourceType.category,
  ),
  Resource(
    title: "Packages & Plugins",
    emoji: "📦",
    type: ResourceType.category,
  ),
  Resource(
    title: "Learning Resources",
    emoji: "📘",
    type: ResourceType.category,
  ),
];

// Blender files
final List<Resource> flutterFiles = [
  Resource(
    title: "Tree View UI",
    emoji: "🌳",
    url: "https://github.com/baumths/flutter_tree_view",
    type: ResourceType.item,
  ),
  Resource(
    title: "Spooky Halloween App",
    emoji: "🎃",
    url: "https://github.com/esentis/Flutter-Halloween-UI",
    type: ResourceType.item,
  ),
  Resource(
    title: "Admin Dashboard",
    emoji: "🏢",
    url: "https://github.com/FlutterFlareLine/FlareLine",
    type: ResourceType.item,
  ),
  // Resource(
  //   title: "Witch's Potion Recipe App",
  //   emoji: "🧙",
  //   url: "https://github.com/esentis/Flutter-Witch-s-Potion-Recipe-App",
  //   type: ResourceType.item,
  // ),
  Resource(
    title: "Portal Login Animation",
    emoji: "🌀",
    url: "https://github.com/abuanwar072/Animated-Login-UI",
    type: ResourceType.item,
  ),
  Resource(
    title: "Treasure Hunt Game",
    emoji: "💰",
    url: "https://github.com/arturograu/treasure_hunter",
    type: ResourceType.item,
  ),
  Resource(
    title: "Smart Home App",
    emoji: "🏠",
    url: "https://github.com/Lakhankumawat/smart-home-app",
    type: ResourceType.item,
  ),
  Resource(
    title: "Space Explorer UI",
    emoji: "🌍",
    url: "https://github.com/TheAlphamerc/flutter_spacexopedia",
    type: ResourceType.item,
  ),
  Resource(
    title: "Furniture Shop UI",
    emoji: "🪑",
    url: "https://github.com/JosephDoUrden/Furniture-App-UI",
    type: ResourceType.item,
  ),
  Resource(
    title: "Hydration Tracker",
    emoji: "🥛",
    url: "https://github.com/fabirt/water-reminder-app",
    type: ResourceType.item,
  ),
  // Resource(
  //   title: "Pokédex App",
  //   emoji: "🔴",
  //   url: "https://github.com/scitbiz/flutter_pokedex",
  //   type: ResourceType.item,
  // ),
  Resource(
    title: "Plant App",
    emoji: "🌱",
    url: "https://github.com/abuanwar072/Plant-App-Flutter-UI",
    type: ResourceType.item,
  ),
];
