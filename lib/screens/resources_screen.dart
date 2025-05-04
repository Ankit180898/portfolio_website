import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/config/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/resource.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../utils/responsive_helper.dart';
import '../controllers/theme_controller.dart';
import 'resource_detail_screen.dart';
import 'dart:ui';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode;

      return Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF18181B) : Colors.white,
        body: Column(
          children: [
            // Navigation bar
            const NavBar(currentIndex: 3),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Responsive.responsiveContainer(
                  context: context,
                  child: Padding(
                    padding: Responsive.responsivePadding(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        _buildHeader(context),
                        const SizedBox(height: 40),
                        _buildCategories(context),
                        const SizedBox(height: 60),
                        _buildBlenderFilesSection(context),
                        const SizedBox(height: 80),
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

  Widget _buildHeader(BuildContext context) {
    final isDarkMode = themeController.isDarkMode;

    return Column(
      children: [
        // Title with emoji and angle brackets
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left arrow
            Text(
              "›",
              style: TextStyle(
                color: isDarkMode ? Colors.grey : Colors.grey,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(width: 8),

            // Emoji
            const Text("🔮", style: TextStyle(fontSize: 32)),
            const SizedBox(width: 12),

            // Resources text
            Text(
              "Resources",
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 8),

            // Right arrow
            Text(
              "‹",
              style: TextStyle(
                color: isDarkMode ? Colors.grey : Colors.grey,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "A curated collection of valuable links and pages",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color:
                  isDarkMode
                      ? themeController.textSecondaryColor
                      : themeController.textSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories(BuildContext context) {
    final isDarkMode = themeController.isDarkMode;
    final isMobile = Responsive.isMobile(context);

    return Column(
      children:
          resourceCategories.map((category) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    // Navigate to the detail page
                    Get.to(() => ResourceDetailScreen(resource: category));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        if (category.emoji != null)
                          Text(
                            "${category.emoji} ",
                            style: const TextStyle(fontSize: 20),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          category.title,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomPaint(
                  painter: DottedLinePainter(
                    color:
                        isDarkMode
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.4),
                  ),
                  size: Size(double.infinity, 1),
                ),
                const SizedBox(height: 8),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildBlenderFilesSection(BuildContext context) {
    final isDarkMode = themeController.isDarkMode;
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // BLENDER FILES header
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            "BLENDER FILES",
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              color: isDarkMode ? Colors.grey : Colors.grey[700],
            ),
          ),
        ),
        CustomPaint(
          painter: DottedLinePainter(
            color:
                isDarkMode
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.4),
          ),
          size: Size(double.infinity, 1),
        ),
        const SizedBox(height: 24),

        // Blender files list
        _buildBlenderFilesList(context),
      ],
    );
  }

  Widget _buildBlenderFilesList(BuildContext context) {
    final isDarkMode = themeController.isDarkMode;
    final isMobile = Responsive.isMobile(context);

    return Column(
      children:
          flutterFiles.map((resource) {
            return Column(
              children: [
                InkWell(
                  onTap:
                      resource.url != null
                          ? () => _launchURL(resource.url!)
                          : null,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        if (resource.emoji != null)
                          Text(
                            "${resource.emoji} ",
                            style: const TextStyle(fontSize: 20),
                          ),
                        const SizedBox(width: 8),
                        Text(
                          resource.title,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomPaint(
                  painter: DottedLinePainter(
                    color:
                        isDarkMode
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.4),
                  ),
                  size: Size(double.infinity, 1),
                ),
                const SizedBox(height: 8),
              ],
            );
          }).toList(),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}

// Custom painter for dotted line
class DottedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DottedLinePainter({
    required this.color,
    this.dashWidth = 5,
    this.dashSpace = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DottedLinePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.dashWidth != dashWidth ||
      oldDelegate.dashSpace != dashSpace;
}
