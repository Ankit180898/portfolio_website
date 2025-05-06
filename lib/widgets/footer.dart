import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../utils/responsive_helper.dart';
import '../config/theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final themeController = Get.find<ThemeController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child:
          isMobile
              ? _buildMobileLayout(context, themeController)
              : _buildDesktopLayout(context, themeController),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    ThemeController themeController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Credit part
        Row(
          children: [
            Text(
              "Crafted with ",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                color: themeController.textMutedColor,
                fontSize: 14,
              ),
            ),
            const Text("🖤", style: TextStyle(fontSize: 14)),
            Text(
              " by Ankit",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                color: themeController.textMutedColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Social media icons
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildSocialIcon(
              FontAwesomeIcons.github,
              "https://github.com/Ankit180898",
              themeController,
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              FontAwesomeIcons.linkedinIn,
              "https://www.linkedin.com/in/ankitme1808/",
              themeController,
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              FontAwesomeIcons.dribbble,
              "https://dribbble.com/ankit-me180898",
              themeController,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ThemeController themeController,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Credit part
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Crafted with ",
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    color: themeController.textMutedColor,
                    fontSize: 14,
                  ),
                ),
                const Text("🖤", style: TextStyle(fontSize: 14)),
                Text(
                  " by Ankit",
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    color: themeController.textMutedColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Social media icons
        Row(
          children: [
            _buildSocialIcon(
              FontAwesomeIcons.github,
              "https://github.com/Ankit180898",
              themeController,
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              FontAwesomeIcons.linkedinIn,
              "https://www.linkedin.com/in/ankitme1808/",
              themeController,
            ),
            const SizedBox(width: 16),
            _buildSocialIcon(
              FontAwesomeIcons.dribbble,
              "https://dribbble.com/ankit-me180898",
              themeController,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(
    IconData icon,
    String url,
    ThemeController themeController,
  ) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => _launchURL(url),
      child: FaIcon(icon, size: 18, color: themeController.textMutedColor),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
