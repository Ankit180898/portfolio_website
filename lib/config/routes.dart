import 'package:get/get.dart';
import '../screens/home_screen.dart';
import '../screens/blog_screen.dart';
import '../screens/blog_detail_screen.dart';
import '../screens/projects_screen.dart';
import '../screens/project_detail_screen.dart';
import '../screens/about_screen.dart';
import '../screens/now_screen.dart';
// import '../screens/book_notes_screen.dart';
// import '../screens/resources_screen.dart';

class AppRoutes {
  // Private constructor
  AppRoutes._();

  // Route names
  static const String home = '/';
  static const String blog = '/blog';
  static const String blogDetail = '/blog/detail';
  static const String works = '/works';
  static const String worksDetail = '/works/detail';
  static const String about = '/about';
  static const String now = '/now';
  // static const String bookNotes = '/book-notes';
  // static const String resources = '/resources';

  // Route definitions
  static final List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 180),
    ),
    GetPage(
      name: works,
      page: () => const ProjectsScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 180),
    ),
    GetPage(
      name: worksDetail,
      page: () => const ProjectDetailScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 180),
    ),
    GetPage(
      name: blog,
      page: () => const BlogScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 180),
    ),
    GetPage(
      name: blogDetail,
      page: () => const BlogDetailScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 180),
    ),
    GetPage(
      name: about,
      page: () => const AboutScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 180),
    ),
    GetPage(
      name: now,
      page: () => const NowScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 180),
    ),
  ];
}
