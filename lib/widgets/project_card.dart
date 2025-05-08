import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../models/project.dart';
import '../controllers/projects_controller.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    // Check if we're on mobile (width < 600)
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    // Return the appropriate layout based on screen size
    return isMobile
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final projectsController = Get.find<ProjectsController>();
    final themeController = Get.find<ThemeController>();

    // Get color based on project
    final Color cardColor = _getColorForProject(project.title);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => projectsController.openProject(project),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image/Icon Container
              AspectRatio(
                aspectRatio: 1, // Square aspect ratio
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
                  clipBehavior: Clip.antiAlias,
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
                    child: Center(child: getProjectIcon(project.title)),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Project Title
              Text(
                project.title,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: AppTypography.font20,
                  fontWeight: AppTheme.semiBold,
                  color: themeController.textPrimaryColor,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              // Project Timeline (if available)
              // if (project.timeline != null && project.timeline!.isNotEmpty)
              //   Container(
              //     margin: const EdgeInsets.only(bottom: 8),
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 12,
              //       vertical: 3,
              //     ),
              //     decoration: BoxDecoration(
              //       color: themeController.isDarkMode
              //           ? const Color(0xFF333333)
              //           : const Color(0xFFEEEEEE),
              //       borderRadius: BorderRadius.circular(4),
              //     ),
              //     child: Text(
              //       project.timeline ?? "",
              //       style: TextStyle(
              //         fontFamily: AppTheme.fontFamily,
              //         fontSize: AppTypography.font14,
              //         fontWeight: AppTheme.regular,
              //         color: themeController.textSecondaryColor,
              //       ),
              //     ),
              //   ),

              // Project Description
              Text(
                project.description,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: AppTypography.font16,
                  height: 1.4,
                  color: themeController.textSecondaryColor,
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

  Widget _buildMobileLayout(BuildContext context) {
    final projectsController = Get.find<ProjectsController>();
    final themeController = Get.find<ThemeController>();

    // Get color based on project
    final Color cardColor = _getColorForProject(project.title);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => projectsController.openProject(project),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project icon/image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: cardColor,
                    border: Border.all(
                      width: 1,
                      color: AppTheme.borderColor(themeController.isDarkMode),
                    ),
                  ),
                  child: Center(child: getProjectIcon(project.title, size: 40)),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Project Timeline (if available)
                    // if (project.timeline != null && project.timeline!.isNotEmpty)
                    //   Container(
                    //     margin: const EdgeInsets.only(bottom: 4),
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 8,
                    //       vertical: 2,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       color: themeController.isDarkMode
                    //           ? const Color(0xFF333333)
                    //           : const Color(0xFFEEEEEE),
                    //       borderRadius: BorderRadius.circular(4),
                    //     ),
                    //     child: Text(
                    //       project.timeline ?? "",
                    //       style: TextStyle(
                    //         fontFamily: AppTheme.fontFamily,
                    //         fontSize: AppTypography.font12,
                    //         fontWeight: AppTheme.regular,
                    //         color: themeController.textSecondaryColor,
                    //       ),
                    //     ),
                    //   ),
                    const SizedBox(height: 4),

                    // Project description
                    Text(
                      project.description,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTypography.font14,
                        height: 1.4,
                        color: themeController.textSecondaryColor,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget getProjectIcon(String title, {double? size}) {
    final double iconSize = size ?? 64.0;

    switch (title) {
      case "Sheqonomi":
        return FaIcon(
          FontAwesomeIcons.podcast,
          size: iconSize,
          color: Colors.white,
        );
      case "Home|Home 4IM":
        return SvgPicture.asset(
          "assets/images/icons/home4im.svg",
          width: iconSize,
          height: iconSize,
        );
      case "MonkeyType Clone":
        return FaIcon(
          FontAwesomeIcons.keyboard,
          size: iconSize,
          color: Colors.white,
        );
      case "Spendify":
        return FaIcon(
          FontAwesomeIcons.wallet,
          size: iconSize,
          color: Colors.white,
        );
      case "FlutterStack":
        return FaIcon(
          FontAwesomeIcons.flutter,
          size: iconSize,
          color: Colors.white,
        );
      case "Artwork Images":
        return FaIcon(
          FontAwesomeIcons.artstation,
          size: iconSize,
          color: Colors.white,
        );
      case "BlogD":
        return FaIcon(
          FontAwesomeIcons.blog,
          size: iconSize,
          color: Colors.white,
        );
      case "Stock Search":
        return Image.asset(
          "assets/images/icons/stock.png",
          width: iconSize,
          height: iconSize,
        );
      case "News App":
        return FaIcon(
          FontAwesomeIcons.newspaper,
          size: iconSize,
          color: Colors.white,
        );
      case "BlingBill":
        return Image.asset(
          "assets/images/icons/bling.png",
          width: iconSize,
          height: iconSize,
        );
      case "Vision AI":
        return FaIcon(
          FontAwesomeIcons.brain,
          size: iconSize,
          color: Colors.white,
        );
      case "Flight Tracker":
        return FaIcon(
          FontAwesomeIcons.plane,
          size: iconSize,
          color: Colors.white,
        );
      case "Mediflow":
        return FaIcon(
          FontAwesomeIcons.userDoctor,
          size: iconSize,
          color: Colors.white,
        );
      case "Notion Icons 3D":
        return FaIcon(
          FontAwesomeIcons.box,
          size: iconSize,
          color: Colors.white,
        );
      default:
        return FaIcon(
          FontAwesomeIcons.box,
          size: iconSize,
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
      case "Artwork Images":
        return const Color(0xFFFF4081); // Pink
      case "Home|Home 4IM":
        return const Color(0xFFB3E141); // Bright green
      case "BlingBill":
        return const Color.fromARGB(255, 255, 213, 140); // Dark grey/black
      case "Sheqonomi":
        return const Color(0xFF039BE5); // Light blue
      case "MonkeyType Clone":
        return const Color(0xFF8D7B68); // Brown
      case "Notion Icons 3D":
        return const Color(0xFF9370DB); // Medium purple for gradient background
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
