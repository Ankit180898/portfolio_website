import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../widgets/footer.dart';
import '../widgets/nav_bar.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDarkMode;
      final theme = Theme.of(context);
      final isDesktop = MediaQuery.of(context).size.width > 768;
      final width = MediaQuery.of(context).size.width;
      final isMobile = width < AppBreakpoints.md;

      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF18181B) : Colors.white,
        body: Column(
          children: [
            // Navigation bar - use standard navbar for both mobile and desktop
            const NavBar(currentIndex: 4),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: isMobile ? width : AppLayout.maxContentWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? AppLayout.paddingMD : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // About Me section
                        const SizedBox(height: 60),
                        Text(
                          'About Me',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: isDesktop ? 48 : 40,
                            fontWeight: AppTheme.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Greeting
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 20,
                              fontWeight: AppTheme.semiBold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            children: const [
                              TextSpan(text: 'Hi '),
                              TextSpan(text: '👋'),
                              TextSpan(text: ', Nice to meet you!'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Bio Text
                        Text(
                          "I'm Ankit Kumar, a Flutter Developer specializing in cross-platform mobile application development. I hold a degree from the University of Engineering & Management, Kolkata, where I cultivated my technical foundations.",
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 18,
                            fontWeight: AppTheme.regular,
                            color: (isDark ? Colors.white : Colors.black)
                                .withOpacity(0.8),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text(
                          "My expertise lies in developing robust, high-performance applications with clean architecture and intuitive interfaces. I am particularly adept at translating intricate designs into fluid, responsive user experiences across multiple platforms.",
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 18,
                            fontWeight: AppTheme.regular,
                            color: (isDark ? Colors.white : Colors.black)
                                .withOpacity(0.8),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 18,
                              fontWeight: AppTheme.regular,
                              color: (isDark ? Colors.white : Colors.black)
                                  .withOpacity(0.8),
                              height: 1.6,
                            ),
                            children: [
                              const TextSpan(
                                text:
                                    "I currently reside in Kolkata, West Bengal, India, where I actively seek collaborative opportunities with forward-thinking teams. I welcome discussions about potential projects, technical challenges, or innovations in mobile development. For more information on my current focus, see what I'm doing ",
                              ),
                              TextSpan(
                                text: "now",
                                style: TextStyle(
                                  color: (isDark ? Colors.white : Colors.black)
                                      .withOpacity(0.8),
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => Navigator.pushNamed(
                                            context,
                                            '/now',
                                          ),
                              ),
                              const TextSpan(text: "."),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Contact buttons
                        Row(
                          children: [
                            _buildButton(
                              context,
                              icon: FontAwesomeIcons.envelope,
                              label: "Say hello!",
                              onPressed:
                                  () => _launchURL(
                                    'mailto:ankit.me180898@gmail.com',
                                  ),
                              isPrimary: true,
                              isDark: isDark,
                            ),
                            const SizedBox(width: 12),
                            _buildButton(
                              context,
                              icon: FontAwesomeIcons.mugHot,
                              label: "Buy Me a Coffee",
                              onPressed:
                                  () => _launchURL(
                                    'https://www.buymeacoffee.com/example',
                                  ),
                              isPrimary: false,
                              isDark: isDark,
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),

                        // Desk Setup
                        _buildSectionHeader(context, 'DESK SETUP', isDark),
                        const SizedBox(height: 20),
                        _buildDeskSetupImage(context, isDark),
                        const SizedBox(height: 60),

                        // Software Stack
                        _buildSectionHeader(context, 'SOFTWARE STACK', isDark),
                        const SizedBox(height: 20),
                        _buildSoftwareStack(context, isDark),

                        // Timeline
                        const SizedBox(height: 60),
                        _buildSectionHeader(context, 'TIMELINE', isDark),
                        const SizedBox(height: 20),
                        _buildTimeline(context, isDark),

                        const SizedBox(height: 80),

                        // Footer
                        const Footer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
    required bool isDark,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: FaIcon(
        icon,
        size: 16,
        color:
            isPrimary
                ? (isDark ? Colors.black : Colors.white)
                : (isDark ? Colors.white : Colors.black),
      ),
      label: Text(
        label,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 14,
          color:
              isPrimary
                  ? (isDark ? Colors.black : Colors.white)
                  : (isDark ? Colors.white : Colors.black),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isPrimary
                ? (isDark ? Colors.white : Colors.black)
                : Colors.transparent,
        foregroundColor:
            isPrimary
                ? (isDark ? Colors.black : Colors.white)
                : (isDark ? Colors.white : Colors.black),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        side:
            isPrimary
                ? BorderSide.none
                : BorderSide(
                  color: isDark ? Colors.white70 : Colors.black54,
                  width: 1,
                ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, bool isDark) {
    final textColor = isDark ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 14,
            fontWeight: AppTheme.medium,
            letterSpacing: 1.2,
            color: textColor.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          width: double.infinity,
          color: textColor.withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _buildDeskSetupImage(BuildContext context, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 240,
        color: (isDark ? Colors.black : Colors.grey[200])?.withOpacity(0.3),
        child: Image.network(
          'https://placehold.co/800x400/1a1a1a/4d4d4d?text=Desk+Setup',
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return child;
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                "Desk Setup Image",
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 14,
                  color: (isDark ? Colors.white : Colors.black).withOpacity(
                    0.5,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSoftwareStack(BuildContext context, bool isDark) {
    final softwareList = [
      {"name": "Figma", "icon": FontAwesomeIcons.figma},
      {"name": "Voicenotes", "icon": FontAwesomeIcons.microphone},
      {"name": "Arc", "icon": FontAwesomeIcons.globe},
      {"name": "Raycast", "icon": FontAwesomeIcons.search},
      {"name": "Cron", "icon": FontAwesomeIcons.calendar},
      {"name": "Music", "icon": FontAwesomeIcons.music},
      {"name": "Todoist", "icon": FontAwesomeIcons.listCheck},
      {"name": "Notes", "icon": FontAwesomeIcons.noteSticky},
      {"name": "DaVinci Resolve", "icon": FontAwesomeIcons.film},
      {"name": "Blender", "icon": FontAwesomeIcons.cubes},
      {"name": "VS Code", "icon": FontAwesomeIcons.code},
      {"name": "Podcasts", "icon": FontAwesomeIcons.podcast},
      {"name": "Bitwarden", "icon": FontAwesomeIcons.lock},
      {"name": "ChatGPT", "icon": FontAwesomeIcons.message},
      {"name": "Flow", "icon": FontAwesomeIcons.water},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          softwareList.map((software) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    software["icon"] as IconData,
                    size: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    software["name"] as String,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildTimeline(BuildContext context, bool isDark) {
    final jobs = [
      {
        "company": "Mobile Application Developer",
        "position": "Freelance",
        "type": "Remote",
        "startDate": "MAY 23",
        "endDate": "PRESENT",
        "icon": FontAwesomeIcons.mobileScreen,
        "color": const Color(0xFF5B9FFF),
        "isFirst": true,
      },
      {
        "company": "Flutter Developer",
        "position": "ControlShift",
        "type": "Hybrid",
        "startDate": "FEB 23",
        "endDate": "APR 23",
        "icon": FontAwesomeIcons.code,
        "color": const Color(0xFF4ADE80),
        "isFirst": false,
      },
      {
        "company": "Android Developer",
        "position": "Unified Infotech",
        "type": "Remote",
        "startDate": "APR 21",
        "endDate": "NOV 22",
        "icon": FontAwesomeIcons.android,
        "color": const Color(0xFF5B9FFF),
        "isFirst": false,
      },
    ];

    final textColor = isDark ? Colors.white : Colors.black;

    return Column(
      children:
          jobs.map((job) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: job["color"] as Color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FaIcon(
                      job["icon"] as IconData,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              job["company"] as String,
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 18,
                                fontWeight: AppTheme.semiBold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_outward,
                              size: 16,
                              color: textColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              job["position"] as String,
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 15,
                                fontWeight: AppTheme.regular,
                                color: textColor.withOpacity(0.7),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                "◆",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: textColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                            Text(
                              job["type"] as String,
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 15,
                                fontWeight: AppTheme.regular,
                                color: textColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isDark
                                    ? const Color(0xFF27272A)
                                    : Colors.grey[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "${job["startDate"]} — ${job["endDate"]}",
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 13,
                              fontWeight: AppTheme.medium,
                              color: textColor.withOpacity(0.7),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
