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
  Resource(title: "Animations & Effects", emoji: "🎞️", type: ResourceType.category),
  Resource(title: "State Management", emoji: "🧠", type: ResourceType.category),
  Resource(title: "Firebase Integration", emoji: "🔥", type: ResourceType.category),
  Resource(title: "Open Source Projects", emoji: "📂", type: ResourceType.category),
  Resource(title: "Packages & Plugins", emoji: "📦", type: ResourceType.category),
  Resource(title: "Learning Resources", emoji: "📘", type: ResourceType.category),
];

// Blender files
final List<Resource> flutterFiles = [
  Resource(
    title: "Tree View UI",
    emoji: "🌳",
    url: "https://github.com/abdelrahman-gaber/flutter_treeview",
    type: ResourceType.item,
  ),
  Resource(
    title: "Spooky Halloween App",
    emoji: "🎃",
    url: "https://dribbble.com/shots/16677541-Halloween-App-Concept",
    type: ResourceType.item,
  ),
  Resource(
    title: "Avengers Dashboard",
    emoji: "🏢",
    url: "https://github.com/mohak1283/AvengersApp-Flutter",
    type: ResourceType.item,
  ),
  Resource(
    title: "Witch's Potion Recipe App",
    emoji: "🧙",
    url: "https://dribbble.com/shots/14326406-Witch-s-Recipe-App",
    type: ResourceType.item,
  ),
  Resource(
    title: "Portal Login Animation",
    emoji: "🌀",
    url: "https://github.com/abuanwar072/Animated-Login-UI",
    type: ResourceType.item,
  ),
  Resource(
    title: "Treasure Hunt Game UI",
    emoji: "💰",
    url: "https://github.com/FireHeartGames/treasure-hunt-flutter",
    type: ResourceType.item,
  ),
  Resource(
    title: "Smart Home App",
    emoji: "🏠",
    url: "https://github.com/mohak1283/smart_home_flutter",
    type: ResourceType.item,
  ),
  Resource(
    title: "Space Explorer UI",
    emoji: "🌍",
    url: "https://github.com/akshitgupta9/Flutter-Planet-App",
    type: ResourceType.item,
  ),
  Resource(
    title: "Furniture Shop UI",
    emoji: "🪑",
    url: "https://github.com/abuanwar072/Furniture-App-UI",
    type: ResourceType.item,
  ),
  Resource(
    title: "Hydration Tracker",
    emoji: "🥛",
    url: "https://github.com/lucianojung/hydrate-me",
    type: ResourceType.item,
  ),
  Resource(
    title: "Pokédex App",
    emoji: "🔴",
    url: "https://github.com/scitbiz/flutter_pokedex",
    type: ResourceType.item,
  ),
  Resource(
    title: "Plant Care App",
    emoji: "🌱",
    url: "https://github.com/JideGuru/PlantApp",
    type: ResourceType.item,
  ),
  Resource(
    title: "Christmas Countdown",
    emoji: "🎅",
    url: "https://github.com/wajahatkarim3/FlutterXmasApp",
    type: ResourceType.item,
  ),
  Resource(
    title: "Donut Ordering App",
    emoji: "🍩",
    url: "https://github.com/TahseenAhmed/donut_shop_ui",
    type: ResourceType.item,
  ),
];

