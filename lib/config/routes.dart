import 'package:get/get.dart';
import '../screens/home_screen.dart';
import '../screens/blog_screen.dart';
import '../screens/book_notes_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/about_screen.dart';
import '../screens/now_screen.dart';
import '../screens/resources_screen.dart';

class AppRoutes {
  // Private constructor
  AppRoutes._();

  // Route names
  static const String home = '/';
  static const String blog = '/blog';
  static const String bookNotes = '/book-notes';
  static const String works = '/works';
  static const String resources = '/resources';
  static const String about = '/about';
  static const String now = '/now';

  // Route definitions
  static final List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: works,
      page: () => const ProjectsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: blog,
      page: () => const BlogScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: bookNotes,
      page: () => const BookNotesScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: resources,
      page: () => const ResourcesScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: about,
      page: () => const AboutScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: now,
      page: () => const NowScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
