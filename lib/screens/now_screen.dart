import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/widgets/footer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/theme_controller.dart';
import '../controllers/now_controller.dart';
import '../utils/responsive_helper.dart';
import '../widgets/nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NowScreen extends StatelessWidget {
  const NowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final ThemeController themeController = Get.find<ThemeController>();

    // Wrap the entire screen in Obx to listen for theme changes
    return Obx(() {
      final isDarkMode = themeController.isDarkMode;

      // Override secondary color for dark mode only in Now screen
      final textSecondaryColor =
          isDarkMode ? Colors.white : themeController.textSecondaryColor;

      final NowController nowController = Get.find<NowController>();

      return Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF18181B) : Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Navigation bar for both mobile and desktop
              const NavBar(currentIndex: 5),

              // Now content
              Responsive.responsiveContainer(
                context: context,
                child: Padding(
                  padding:
                      isMobile
                          ? const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 40,
                          )
                          : Responsive.responsivePadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isMobile)
                        _buildMobileHeader(
                          context,
                          isDarkMode,
                          textSecondaryColor,
                        )
                      else
                        _buildDesktopHeader(
                          context,
                          isDarkMode,
                          textSecondaryColor,
                        ),

                      const SizedBox(height: 24),

                      // Live indicator
                      Obx(
                        () =>
                            nowController.isLive.value
                                ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isDarkMode
                                            ? Colors.red.withOpacity(0.2)
                                            : Colors.red.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'LIVE',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : const SizedBox(),
                      ),
                      const SizedBox(height: 48),

                      _buildStatusItemWithIcon(
                        context,
                        icon: FontAwesomeIcons.flutter,
                        text: 'Flutter Developer @ ',
                        link: 'Vajihi LLC',
                        isDarkMode: isDarkMode,
                        textSecondaryColor: textSecondaryColor,
                      ),
                      const SizedBox(height: 32),

                      _buildStatusItemWithIcon(
                        context,
                        icon: FontAwesomeIcons.code,
                        text: 'Working on - ',
                        link: 'Flutter projects',
                        secondText: ' & ',
                        secondLink: 'UI/UX Design',
                        isDarkMode: isDarkMode,
                        textSecondaryColor: textSecondaryColor,
                      ),
                      const SizedBox(height: 32),

                      _buildStatusItemWithIcon(
                        context,
                        icon: FontAwesomeIcons.book,
                        text: 'Learning - ',
                        link: 'Javascript',
                        secondText: ' & ',
                        secondLink: 'Flutter Architecture',
                        isDarkMode: isDarkMode,
                        textSecondaryColor: textSecondaryColor,
                      ),
                      const SizedBox(height: 32),

                      _buildStatusItemWithIcon(
                        context,
                        icon: FontAwesomeIcons.locationDot,
                        text: 'Living in Kolkata, West Bengal, India',
                        isDarkMode: isDarkMode,
                        textSecondaryColor: textSecondaryColor,
                      ),

                      const SizedBox(height: 80),
                      Responsive.responsiveContainer(
                        context: context,
                        child: Padding(
                          padding: Responsive.responsivePadding(context),
                          child: const Footer(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMobileHeader(
    BuildContext context,
    bool isDarkMode,
    Color textSecondaryColor,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌱', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 10),
            Text(
              'Now',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "What I'm currently focused on in Flutter development and mobile application design",
          style: TextStyle(
            fontSize: 16,
            color: textSecondaryColor,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDesktopHeader(
    BuildContext context,
    bool isDarkMode,
    Color textSecondaryColor,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '〈',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.grey,
                fontSize: 24,
              ),
            ),
            const SizedBox(width: 8),
            const Text('🌱', style: TextStyle(fontSize: 30)),
            const SizedBox(width: 8),
            Text(
              'Now',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '〉',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.grey,
                fontSize: 24,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "What I'm currently focused on in Flutter development and mobile application design",
          style: TextStyle(fontSize: 18, color: textSecondaryColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Updated status item with FontAwesome icons
  Widget _buildStatusItemWithIcon(
    BuildContext context, {
    required IconData icon,
    required String text,
    String? link,
    String? secondText,
    String? secondLink,
    required bool isDarkMode,
    required Color textSecondaryColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(icon, size: 18, color: textSecondaryColor),
        const SizedBox(width: 16),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontSize: 16,
                height: 1.5,
                color: textSecondaryColor,
              ),
              children: [
                TextSpan(text: text),
                if (link != null)
                  TextSpan(
                    text: link,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                if (secondText != null) TextSpan(text: secondText),
                if (secondLink != null)
                  TextSpan(
                    text: secondLink,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(
    BuildContext context,
    NowController nowController,
    bool isDarkMode,
    Color textSecondaryColor,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Crafted with heart
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Crafted with ',
                style: TextStyle(color: textSecondaryColor, fontSize: 14),
              ),
              Text('❤️', style: TextStyle(fontSize: 14)),
              Text(
                ' by Ankit',
                style: TextStyle(color: textSecondaryColor, fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Social links updated to match screenshot
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(
                FontAwesomeIcons.github,
                textSecondaryColor,
                url: "https://github.com/Ankit180898",
              ),
              _buildSocialIcon(
                FontAwesomeIcons.linkedin,
                textSecondaryColor,
                url: "https://www.linkedin.com/in/ankitme1808/",
              ),
              _buildSocialIcon(
                FontAwesomeIcons.dribbble,
                textSecondaryColor,
                url: "https://dribbble.com/ankit-me180898",
              ),
              _buildSocialIcon(
                FontAwesomeIcons.envelope,
                textSecondaryColor,
                url: "mailto:ankit.me180898@gmail.com",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color, {required String url}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () => _launchURL(url),
        icon: FaIcon(icon, color: color, size: 22),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}
