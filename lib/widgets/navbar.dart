// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../config/routes.dart';
// import '../utils/responsive_utils.dart';

// class NavBar extends StatelessWidget {
//   const NavBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveUtils.isMobile(context) 
//         ? _buildMobileNavBar(context) 
//         : _buildDesktopNavBar(context);
//   }

//   Widget _buildDesktopNavBar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildLogo(context),
//           Row(
//             children: [
//               _buildNavItem(context, 'works', AppRoutes.projects),
//               const SizedBox(width: 32),
//               _buildNavItem(context, 'blog', '/blog'),
//               const SizedBox(width: 32),
//               _buildNavItem(context, 'book notes', '/book-notes'),
//               const SizedBox(width: 32),
//               _buildNavItem(context, 'resources', AppRoutes.resources),
//               const SizedBox(width: 32),
//               _buildNavItem(context, 'about', AppRoutes.about),
//               const SizedBox(width: 32),
//               _buildNavItem(context, 'now', AppRoutes.now),
//               const SizedBox(width: 24),
//               _buildThemeToggle(context),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMobileNavBar(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildLogo(context),
//           Row(
//             children: [
//               _buildThemeToggle(context),
//               const SizedBox(width: 16),
//               IconButton(
//                 icon: const Icon(Icons.menu),
//                 onPressed: () {
//                   _showMobileMenu(context);
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLogo(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Get.toNamed(AppRoutes.home),
//       child: Row(
//         children: [
//           Text(
//             'VG',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(BuildContext context, String title, String route) {
//     final isActive = Get.currentRoute == route;
    
//     return InkWell(
//       onTap: () => Get.toNamed(route),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
//           color: isActive 
//               ? Theme.of(context).textTheme.bodyLarge!.color 
//               : Theme.of(context).textTheme.bodyMedium!.color,
//         ),
//       ),
//     );
//   }

//   Widget _buildThemeToggle(BuildContext context) {
//     final themeController = Get.find<ThemeController>();

//     return IconButton(
//       icon: Icon(
//         themeController.isDarkMode
//             ? Icons.dark_mode_outlined
//             : Icons.light_mode_outlined,
//       ),
//       onPressed: () {
//         // Toggle the theme
//         themeController.toggleTheme();
//       },
//     );
//   }

//   void _showMobileMenu(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.symmetric(vertical: 32),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _buildMobileNavItem(context, 'Works', AppRoutes.projects),
//               _buildMobileNavItem(context, 'Blog', '/blog'),
//               _buildMobileNavItem(context, 'Book Notes', '/book-notes'),
//               _buildMobileNavItem(context, 'Resources', AppRoutes.resources),
//               _buildMobileNavItem(context, 'About', AppRoutes.about),
//               _buildMobileNavItem(context, 'Now', AppRoutes.now),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildMobileNavItem(BuildContext context, String title, String route) {
//     return ListTile(
//       title: Text(
//         title,
//         style: Theme.of(context).textTheme.titleLarge,
//         textAlign: TextAlign.center,
//       ),
//       onTap: () {
//         Navigator.pop(context);
//         Get.toNamed(route);
//       },
//     );
//   }
// }