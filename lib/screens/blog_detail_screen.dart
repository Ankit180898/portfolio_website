import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/blog_post.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BlogPost? post = Get.arguments as BlogPost?;
    if (post == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Get.back());
      return const SizedBox.shrink();
    }
    final themeController = Get.find<ThemeController>();
    final isMobile = MediaQuery.of(context).size.width < AppBreakpoints.md;

    return Obx(() {
      return Scaffold(
        backgroundColor: themeController.backgroundColor,
        body: Column(
          children: [
            const NavBar(currentIndex: 1),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: isMobile
                        ? MediaQuery.of(context).size.width
                        : AppLayout.maxContentWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? AppLayout.paddingMD : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        _buildBackButton(themeController),
                        const SizedBox(height: 32),
                        _buildHeader(context, post, themeController, isMobile),
                        const SizedBox(height: 48),
                        _buildContent(context, post, themeController),
                        const SizedBox(height: 48),
                        if (post.link != null)
                          _buildCta(post, themeController),
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

  Widget _buildBackButton(ThemeController themeController) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 14,
            color: themeController.textMutedColor,
          ),
          const SizedBox(width: 8),
          Text(
            'Back to Blog',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 14,
              color: themeController.textMutedColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    BlogPost post,
    ThemeController themeController,
    bool isMobile,
  ) {
    final cardColor = _colorForTitle(post.title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero banner
        ClipRRect(
          borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
          child: AspectRatio(
            aspectRatio: isMobile ? 2 : 3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: cardColor),
                CustomPaint(
                  painter: _DiagonalLines(
                    color: Colors.white.withValues(alpha: 0.07),
                  ),
                ),
                Center(
                  child: FaIcon(
                    _iconForTitle(post.title),
                    size: 56,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),

        // "My Writing" badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'My Writing',
            style: TextStyle(
              color: Color(0xFF6366F1),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Title
        Text(
          post.title,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: isMobile ? 24 : 32,
            fontWeight: AppTheme.bold,
            color: themeController.textPrimaryColor,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 16),

        // Date + read time
        Row(
          children: [
            Text(
              post.date,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 14,
                color: themeController.textMutedColor,
              ),
            ),
            if (post.readTime != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '·',
                  style: TextStyle(color: themeController.textMutedColor),
                ),
              ),
              FaIcon(FontAwesomeIcons.clock,
                  size: 12, color: themeController.textMutedColor),
              const SizedBox(width: 4),
              Text(
                post.readTime!,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 14,
                  color: themeController.textMutedColor,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    BlogPost post,
    ThemeController themeController,
  ) {
    if (post.sections == null || post.sections!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: post.sections!.map((section) {
        return _buildSection(context, section, themeController);
      }).toList(),
    );
  }

  Widget _buildSection(
    BuildContext context,
    BlogSection section,
    ThemeController themeController,
  ) {
    switch (section.type) {
      case BlogSectionType.heading:
        return Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 12),
          child: Text(
            section.text!,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 22,
              fontWeight: AppTheme.bold,
              color: themeController.textPrimaryColor,
              height: 1.3,
            ),
          ),
        );

      case BlogSectionType.subheading:
        return Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 8),
          child: Text(
            section.text!,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 18,
              fontWeight: AppTheme.semiBold,
              color: themeController.textPrimaryColor,
              height: 1.3,
            ),
          ),
        );

      case BlogSectionType.paragraph:
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            section.text!,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 16,
              height: 1.75,
              color: themeController.textSecondaryColor,
            ),
          ),
        );

      case BlogSectionType.bulletList:
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: section.items!.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: themeController.textMutedColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 16,
                          height: 1.7,
                          color: themeController.textSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );

      case BlogSectionType.techTable:
        return Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: _buildTable(section.tableRows!, themeController),
        );

      case BlogSectionType.divider:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Container(
            height: 1,
            color: themeController.borderColor,
          ),
        );
    }
  }

  Widget _buildTable(
      List<List<String>> rows, ThemeController themeController) {
    final isDark = themeController.isDarkMode;
    final headerBg =
        isDark ? const Color(0xFF27272A) : const Color(0xFFF4F4F5);
    final rowBg = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final altBg =
        isDark ? const Color(0xFF222224) : const Color(0xFFFAFAFA);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: themeController.borderColor),
          borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
        ),
        child: Column(
          children: rows.asMap().entries.map((entry) {
            final i = entry.key;
            final row = entry.value;
            final isHeader = i == 0;

            return Container(
              color: isHeader ? headerBg : (i.isOdd ? altBg : rowBg),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(
                      row[0],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 14,
                        fontWeight: isHeader ? AppTheme.semiBold : AppTheme.regular,
                        color: isHeader
                            ? themeController.textPrimaryColor
                            : themeController.textMutedColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row[1],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 14,
                        fontWeight: isHeader ? AppTheme.semiBold : AppTheme.regular,
                        color: isHeader
                            ? themeController.textPrimaryColor
                            : themeController.textSecondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCta(BlogPost post, ThemeController themeController) {
    final isDark = themeController.isDarkMode;
    final isGitHub = post.link!.contains('github.com');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF4F4F5),
        borderRadius: BorderRadius.circular(AppLayout.borderRadiusLG),
        border: Border.all(color: themeController.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isGitHub ? 'View on GitHub' : 'View on Play Store',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 16,
                    fontWeight: AppTheme.semiBold,
                    color: themeController.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isGitHub
                      ? 'Full source code — browse the implementation.'
                      : 'Live on the Play Store — download and try it.',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 14,
                    color: themeController.textMutedColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => _launchUrl(post.link!),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: themeController.textPrimaryColor,
                borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    isGitHub
                        ? FontAwesomeIcons.github
                        : FontAwesomeIcons.googlePlay,
                    size: 14,
                    color: themeController.backgroundColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isGitHub ? 'GitHub' : 'Play Store',
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: AppTheme.semiBold,
                      color: themeController.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  Color _colorForTitle(String title) {
    if (title.toLowerCase().contains('spendify')) return const Color(0xFF4CAF50);
    if (title.toLowerCase().contains('bohri') ||
        title.toLowerCase().contains('cupid')) {
      return const Color(0xFFE91E63);
    }
    return const Color(0xFF6366F1);
  }

  IconData _iconForTitle(String title) {
    if (title.toLowerCase().contains('spendify')) {
      return FontAwesomeIcons.wallet;
    }
    if (title.toLowerCase().contains('bohri') ||
        title.toLowerCase().contains('cupid')) {
      return FontAwesomeIcons.heart;
    }
    return FontAwesomeIcons.newspaper;
  }
}

class _DiagonalLines extends CustomPainter {
  final Color color;
  const _DiagonalLines({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    for (double i = -size.height; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
