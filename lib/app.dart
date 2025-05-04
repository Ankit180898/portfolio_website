import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'config/routes.dart';
import 'config/theme.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the theme controller instance
    final ThemeController themeController = Get.find<ThemeController>();

    // Use Obx to reactively rebuild when theme changes
    return Obx(() {
      print('Rebuilding app with themeMode: ${themeController.themeMode}');
      print('IsDarkMode: ${themeController.isDarkMode}');

      return GetMaterialApp(
        title: 'Ankit Kumar | Portfolio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        getPages: AppRoutes.pages,
        initialRoute: AppRoutes.home,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          );
        },
      );
    });
  }
}
