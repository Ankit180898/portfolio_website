import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/project.dart';
import '../controllers/projects_controller.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MobileProjectListItem extends StatelessWidget {
  final Project project;

  const MobileProjectListItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final projectsController = Get.find<ProjectsController>();
    final themeController = Get.find<ThemeController>();

    // Get color based on project
    final Color cardColor = _getColorForProject(project.title);

    return InkWell(
      onTap: () => projectsController.openProject(project),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project icon/image - square thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Container(
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
          ),
          const SizedBox(width: 16),

          // Project details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project title
                Text(
                  project.title,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: AppTypography.font18,
                    fontWeight: AppTheme.semiBold,
                    color: themeController.textPrimaryColor,
                    height: 1.2,
                  ),
                ),

                // Project date
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(
                    _getProjectPeriod(project.title),
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: AppTypography.font12,
                      fontWeight: AppTheme.regular,
                      color: themeController.textMutedColor,
                      height: 1.2,
                    ),
                  ),
                ),

                // Project description
                Text(
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to get icon based on project title
  Widget _getProjectIcon(String title) {
    switch (title) {
      case "Spendify":
        return const FaIcon(
          FontAwesomeIcons.wallet,
          size: 40,
          color: Colors.white,
        );
      case "Flutter Stack":
        return const FaIcon(
          FontAwesomeIcons.code,
          size: 40,
          color: Colors.white,
        );
      case "Artworks":
        return const FaIcon(
          FontAwesomeIcons.paintBrush,
          size: 40,
          color: Colors.white,
        );
      case "Brainfish":
        return const FaIcon(
          FontAwesomeIcons.fish,
          size: 40,
          color: Colors.white,
        );
      case "Layers":
        return const FaIcon(
          FontAwesomeIcons.layerGroup,
          size: 40,
          color: Colors.white,
        );
      case "Notion Icons 3D":
        return const Text(
          "n.",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      default:
        return const FaIcon(
          FontAwesomeIcons.box,
          size: 40,
          color: Colors.white,
        );
    }
  }

  // Helper to get time period based on project title
  String _getProjectPeriod(String title) {
    switch (title) {
      case "Brainfish":
        return "2022 - PRESENT";
      case "Layers":
        return "PRESENT";
      case "Notion Icons 3D":
        return "2022";
      case "Spendify":
        return "2023 - PRESENT";
      case "Flutter Stack":
        return "2022 - PRESENT";
      case "Artworks":
        return "PRESENT";
      case "Background Remover":
        return "2022";
      default:
        return "2022 - PRESENT";
    }
  }

  // Helper to get color based on project title
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
}
