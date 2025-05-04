import 'package:get/get.dart';
import '../config/routes.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void navigateToProjects() {
    Get.toNamed(AppRoutes.works);
  }

  void navigateToAbout() {
    Get.toNamed(AppRoutes.about);
  }
}
