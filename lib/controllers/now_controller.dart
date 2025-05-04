import 'package:get/get.dart';

class NowController extends GetxController {
  final RxList<String> currentActivities =
      <String>[
        '🛠️ Product Designer @ Brainfish',
        '📚 Reading - Designing Products People Love & Make Epic Money',
        '📍 Living in Kerala, India',
      ].obs;

  final RxBool isLive = true.obs;

  // Links for social media
  final twitterUrl = 'https://twitter.com/yourusername';
  final githubUrl = 'https://github.com/yourusername';
  final blogUrl = 'https://yourblog.com';
  final portfolioUrl = 'https://yourportfolio.com';
  final youtubeUrl = 'https://youtube.com/yourchannel';

  void toggleLiveStatus() {
    isLive.toggle();
  }

  void updateActivity(int index, String newActivity) {
    if (index >= 0 && index < currentActivities.length) {
      currentActivities[index] = newActivity;
    }
  }
}
