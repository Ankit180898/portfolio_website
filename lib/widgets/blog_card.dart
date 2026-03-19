import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../models/blog_post.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../config/routes.dart';
import 'dart:math' as math;

// Badge accent color for personal posts
const Color _personalBadgeColor = Color(0xFF6366F1);

class BlogCard extends StatefulWidget {
  final BlogPost blogPost;

  const BlogCard({super.key, required this.blogPost});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _animationController.forward(),
      onExit: (_) => _animationController.reverse(),
      child: GestureDetector(
        onTap: () {
          if (widget.blogPost.type == BlogPostType.personal) {
            Get.toNamed(AppRoutes.blogDetail, arguments: widget.blogPost);
          } else if (widget.blogPost.link != null) {
            _launchURL(widget.blogPost.link!);
          }
        },
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blog image with placeholder
              ClipRRect(
                borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: _getColorForPost(widget.blogPost.title),
                          borderRadius: BorderRadius.circular(
                            AppLayout.borderRadiusMD,
                          ),
                        ),
                      ),
                      CustomPaint(
                        painter: DiagonalPatternPainter(
                          color: Colors.white.withValues(alpha: 0.1),
                          lineWidth: 2,
                          spacing: 15,
                        ),
                      ),
                      Center(
                        child: FaIcon(
                          _getIconForPost(widget.blogPost.title),
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                      if (widget.blogPost.imageUrl.isNotEmpty)
                        Image.asset(
                          widget.blogPost.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                      // "My Writing" badge for personal posts
                      if (widget.blogPost.type == BlogPostType.personal)
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _personalBadgeColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'My Writing',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Text(
                widget.blogPost.title,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: AppTypography.font16,
                  fontWeight: AppTheme.semiBold,
                  color: themeController.textPrimaryColor.withValues(alpha: 0.8),
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              Text(
                widget.blogPost.date,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  color: themeController.textMutedColor,
                  fontSize: AppTypography.font12,
                  fontWeight: AppTheme.regular,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                widget.blogPost.description,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  color: themeController.textSecondaryColor,
                  fontSize: AppTypography.font14,
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
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
