import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:portfolio_website/app.dart';
import 'controllers/theme_controller.dart';
import 'controllers/about_controller.dart';
import 'controllers/now_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/projects_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage for theme persistence
  await GetStorage.init();

  // Force portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize controllers
  Get.put(ThemeController(), permanent: true);
  Get.put(ProjectsController());
  Get.put(AboutController());
  Get.put(NowController());
  Get.put(HomeController());

  runApp(const PortfolioApp());
}
