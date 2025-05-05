import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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

Future<void> downloadResume(String resumeUrl) async {
  final Uri uri = Uri.parse(resumeUrl);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<void> launchEmail(String email) async {
  final Uri uri = Uri.parse("mailto:$email");
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}




}
