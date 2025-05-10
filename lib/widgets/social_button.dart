import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/user_profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  final SocialLink socialLink;

  const SocialButton({super.key, required this.socialLink});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _launchURL(socialLink.url),
      icon: _getIcon(),
      tooltip: socialLink.name,
    );
  }

  Widget _getIcon() {
    switch (socialLink.icon.toLowerCase()) {
      case 'github':
        return const FaIcon(FontAwesomeIcons.github);
      case 'linkedin':
        return const FaIcon(FontAwesomeIcons.linkedin);
      case 'twitter':
        return const FaIcon(FontAwesomeIcons.twitter);
      case 'instagram':
        return const FaIcon(FontAwesomeIcons.instagram);
      case 'youtube':
        return const FaIcon(FontAwesomeIcons.youtube);
      case 'medium':
        return const FaIcon(FontAwesomeIcons.medium);
      case 'dribbble':
        return const FaIcon(FontAwesomeIcons.dribbble);
      default:
        return const FaIcon(FontAwesomeIcons.link);
    }
  }

  void _launchURL(String url) {
    launchUrl(Uri.parse(url));
  }
}
