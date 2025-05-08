import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../models/blog_post.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import 'dart:math' as math;

class BlogCard extends StatelessWidget {
  final BlogPost blogPost;

  const BlogCard({super.key, required this.blogPost});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    // Card with reduced height and no splash effect
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: blogPost.link != null ? () => _launchURL(blogPost.link!) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog Image with proper error handling and placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Decorative background based on blog title
                    Container(
                      decoration: BoxDecoration(
                        color: _getColorForPost(blogPost.title),
                        borderRadius: BorderRadius.circular(
                          AppLayout.borderRadiusMD,
                        ),
                      ),
                    ),

                    // Diagonal pattern for visual interest
                    CustomPaint(
                      painter: DiagonalPatternPainter(
                        color: Colors.white.withOpacity(0.1),
                        lineWidth: 2,
                        spacing: 15,
                      ),
                    ),

                    // Center icon or logo
                    Center(
                      child: FaIcon(
                        _getIconForPost(blogPost.title),
                        size: 48,
                        color: Colors.white,
                      ),
                    ),

                    if (blogPost.imageUrl.isNotEmpty)
                      Image.asset(
                        blogPost.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Don't show anything on error, we already have our placeholder
                          return const SizedBox.shrink();
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            Text(
              blogPost.title,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: AppTypography.font16,
                fontWeight: AppTheme.semiBold,
                color: themeController.textPrimaryColor.withOpacity(0.8),
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Date
            Text(
              blogPost.date,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                color: themeController.textMutedColor,
                fontSize: AppTypography.font12,
                fontWeight: AppTheme.regular,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),

            // Blog Description
            Text(
              blogPost.description,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                color: themeController.textSecondaryColor,
                fontSize: AppTypography.font14,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // icon based on blog post title
  IconData _getIconForPost(String title) {
    if (title.toLowerCase().contains('design')) {
      return FontAwesomeIcons.pen;
    } else if (title.toLowerCase().contains('health')) {
      return FontAwesomeIcons.heart;
    } else if (title.toLowerCase().contains('video')) {
      return FontAwesomeIcons.video;
    } else if (title.toLowerCase().contains('flutter') ||
        title.toLowerCase().contains('code')) {
      return FontAwesomeIcons.flutter;
    } else {
      return FontAwesomeIcons.newspaper;
    }
  }

  // Helper to get color based on blog post title
  Color _getColorForPost(String title) {
    if (title.toLowerCase().contains('health')) {
      return Colors.teal;
    } else if (title.toLowerCase().contains('video')) {
      return Colors.blue;
    } else if (title.toLowerCase().contains('flutter') ||
        title.toLowerCase().contains('code')) {
      return Colors.indigo;
    } else if (title.toLowerCase().contains('design')) {
      return Colors.purple;
    } else {
      // Generate a stable color based on the title
      final random = math.Random(title.hashCode);
      return Color.fromRGBO(
        random.nextInt(150) + 50,
        random.nextInt(150) + 50,
        random.nextInt(150) + 50,
        1,
      );
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}

// Custom painter for diagonal lines pattern
class DiagonalPatternPainter extends CustomPainter {
  final Color color;
  final double lineWidth;
  final double spacing;

  DiagonalPatternPainter({
    required this.color,
    this.lineWidth = 2.0,
    this.spacing = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = lineWidth
          ..style = PaintingStyle.stroke;

    // Draw diagonal lines going top-left to bottom-right
    for (double i = -size.height; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
