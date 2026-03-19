import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'config/routes.dart';
import 'config/theme.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    // Do NOT wrap GetMaterialApp in Obx — it causes a full app rebuild on every
    // theme change, producing a white flash. Theme switching is handled
    // reactively by Get.changeThemeMode() inside ThemeController._updateTheme.
    return GetMaterialApp(
      title: 'Ankit Kumar | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.home,
      defaultTransition: Transition.noTransition,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}
