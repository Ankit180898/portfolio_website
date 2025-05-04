import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/project.dart';
import '../controllers/projects_controller.dart';
import '../controllers/theme_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final projectsController = Get.find<ProjectsController>();
    final themeController = Get.find<ThemeController>();

    // Get color based on project
    final Color cardColor = _getColorForProject(project.title);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => projectsController.openProject(project),
        child: SizedBox(
          height: 280, // Fixed total height to match SizedBox height in parent
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project image - colored box with icon, fixed height to prevent overflow
              ClipRRect(
                borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
                child: Container(
                  height: 220, // Fixed height for image
                  decoration:
                      project.title == "Notion Icons 3D"
                          ? const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFFA07A), // Light salmon
                                Color(0xFFFF00A0), // Hot pink
                                Color(0xFF9370DB), // Medium purple
                              ],
                            ),
                          )
                          : BoxDecoration(color: cardColor),
                  child: Center(child: _getProjectIcon(project.title)),
                ),
              ),
              const SizedBox(height: 8),

              // Project title with fixed height
              SizedBox(
                height: 24, // Fixed height for title
                child: Text(
                  project.title,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: AppTypography.font18,
                    fontWeight: AppTheme.semiBold,
                    color: themeController.textPrimaryColor,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Project description with fixed height instead of Expanded
              const SizedBox(
                height: 4,
              ), // Small gap between title and description
              SizedBox(
                height:
                    24, // Fixed height that can accommodate two lines of text
                child: Text(
                  project.description,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: AppTypography.font14,
                    height: 1.4,
                    color: themeController.textSecondaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getProjectIcon(String title) {
    switch (title) {
      case "Spendify":
        return const FaIcon(
          FontAwesomeIcons.wallet,
          size: 64,
          color: Colors.white,
        );
      case "Flutter Stack":
        return const FaIcon(
          FontAwesomeIcons.code,
          size: 64,
          color: Colors.white,
        );
      case "Artworks":
        return const FaIcon(
          FontAwesomeIcons.paintBrush,
          size: 64,
          color: Colors.white,
        );
      case "Brainfish":
        return const FaIcon(
          FontAwesomeIcons.fish,
          size: 64,
          color: Colors.white,
        );
      case "Layers":
        return const FaIcon(
          FontAwesomeIcons.layerGroup,
          size: 64,
          color: Colors.white,
        );
      case "Notion Icons 3D":
        return const Text(
          "n.",
          style: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      default:
        return const FaIcon(
          FontAwesomeIcons.box,
          size: 64,
          color: Colors.white,
        );
    }
  }

  Color _getColorForProject(String title) {
    // Return specific colors for featured projects
    switch (title) {
      case "Spendify":
        return const Color(0xFF8BC34A); // Green
      case "Flutter Stack":
        return const Color(0xFF4169E1); // Royal blue
      case "Artworks":
        return const Color(0xFFFF4081); // Pink
      case "Brainfish":
        return const Color(0xFFB3E141); // Bright green
      case "Layers":
        return const Color(0xFF121212); // Dark grey/black
      case "Background Remover":
        return const Color(0xFF039BE5); // Light blue
      default:
        // For other projects, generate a random color
        final random = math.Random(title.hashCode);
        return Color.fromRGBO(
          random.nextInt(200) + 55, // Ensure it's not too dark
          random.nextInt(200) + 55,
          random.nextInt(200) + 55,
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

// Custom painter for fish icon
class FishIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round;

    final Path path = Path();

    // Draw fish body (oval)
    path.addOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.5),
        width: size.width * 0.7,
        height: size.height * 0.4,
      ),
    );

    // Draw tail
    path.moveTo(size.width * 0.85, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.35);
    path.moveTo(size.width * 0.85, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.65);

    // Draw eye
    path.addOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.45),
        width: size.width * 0.1,
        height: size.height * 0.1,
      ),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
