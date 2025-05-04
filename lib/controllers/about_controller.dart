import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class AboutController extends GetxController {
  final RxList<String> skills =
      <String>[
        'Flutter',
        'Dart',
        'UI/UX Design',
        'Product Design',
        'Illustration',
        'React',
        'JavaScript',
        'TypeScript',
        'HTML/CSS',
        'Figma',
        'Blender',
      ].obs;
  final RxBool isResumeDownloading = false.obs;

  // Resume download URL
  final resumeUrl =
      'https://drive.google.com/file/d/1lZJz7b190mjf756-wTrnKvPTAS4o8wPz/view?usp=drive_link';

  Future<void> downloadResume() async {
    isResumeDownloading.value = true;

    try {
      final Uri uri = Uri.parse(resumeUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch resume URL: $e');
    } finally {
      // Set downloading to false after a short delay to show feedback to the user
      Future.delayed(const Duration(seconds: 1), () {
        isResumeDownloading.value = false;
      });
    }
  }
}
