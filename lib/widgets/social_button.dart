import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/user_profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class SocialButton extends StatelessWidget {
  final SocialLink socialLink;

  const SocialButton({super.key, required this.socialLink});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _launchURL(socialLink.url),
        borderRadius: BorderRadius.circular(8),
        splashColor: themeController.textPrimaryColor.withOpacity(0.1),
        highlightColor: themeController.textPrimaryColor.withOpacity(0.05),
        child: Padding(padding: const EdgeInsets.all(8.0), child: _getIcon()),
      ),
    );
  }

  Widget _getIcon() {
    final themeController = Get.find<ThemeController>();
    final iconColor = themeController.textPrimaryColor;

    switch (socialLink.icon.toLowerCase()) {
      case 'github':
        return FaIcon(FontAwesomeIcons.github, color: iconColor);
      case 'linkedin':
        return FaIcon(FontAwesomeIcons.linkedin, color: iconColor);
      case 'twitter':
        return FaIcon(FontAwesomeIcons.twitter, color: iconColor);
      case 'instagram':
        return FaIcon(FontAwesomeIcons.instagram, color: iconColor);
      case 'youtube':
        return FaIcon(FontAwesomeIcons.youtube, color: iconColor);
      case 'medium':
        return FaIcon(FontAwesomeIcons.medium, color: iconColor);
      case 'dribbble':
        return FaIcon(FontAwesomeIcons.dribbble, color: iconColor);
      default:
        return FaIcon(FontAwesomeIcons.link, color: iconColor);
    }
  }

  void _launchURL(String url) {
    launchUrl(Uri.parse(url));
  }
}
