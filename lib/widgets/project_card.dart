import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../models/project.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../config/routes.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();

  // Static icon helper — accessible as ProjectCard.getProjectIcon(title)
  static Widget getProjectIcon(String title, {double? size}) {
    final double iconSize = size ?? 64.0;

    switch (title) {
      case "Bohri Cupid":
        return Image.asset(
          "assets/images/icons/bohra.png",
          width: iconSize,
          height: iconSize,
        );
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
        return Image.asset(
          "assets/images/icons/flutterstack.png",
          width: iconSize,
          height: iconSize,
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

  // Static color helper
  static Color getColorForProject(String title) {
    switch (title) {
      case "Bohri Cupid":
        return const Color(0xFFFFD700);
      case "Spendify":
        return const Color(0xFF8BC34A);
      case "FlutterStack":
        return const Color(0xFF4169E1);
      case "Artwork Images":
        return const Color(0xFFFF4081);
      case "Home|Home 4IM":
        return const Color(0xFFB3E141);
      case "BlingBill":
        return const Color(0xFFFFD58C);
      case "Sheqonomi":
        return const Color(0xFF039BE5);
      case "MonkeyType Clone":
        return const Color(0xFF8D7B68);
      case "Notion Icons 3D":
        return const Color(0xFF9370DB);
      default:
        final random = math.Random(title.hashCode);
        return Color.fromRGBO(
          random.nextInt(200) + 55,
          random.nextInt(200) + 55,
          random.nextInt(200) + 55,
          1,
        );
    }
  }
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  void _onHoverEnter() => setState(() => _isHovered = true);
  void _onHoverExit() => setState(() => _isHovered = false);

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < AppBreakpoints.md;
    return isMobile
        ? _buildMobileLayout(context)
        : _buildDesktopLayout(context);
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final Color cardColor =
        ProjectCard.getColorForProject(widget.project.title);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _onHoverEnter(),
      onExit: (_) => _onHoverExit(),
      child: GestureDetector(
        onTap: () =>
            Get.toNamed(AppRoutes.worksDetail, arguments: widget.project),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image/Icon Container
            AspectRatio(
              aspectRatio: 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: widget.project.title == "Notion Icons 3D"
                    ? BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppLayout.borderRadiusMD),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFFA07A),
                            Color(0xFFFF00A0),
                            Color(0xFF9370DB),
                          ],
                        ),
                        border: Border.all(
                          color: _isHovered
                              ? themeController.textPrimaryColor
                                  .withValues(alpha: 0.2)
                              : Colors.transparent,
                          width: 1,
                        ),
                      )
                    : BoxDecoration(
                        color: cardColor,
                        borderRadius:
                            BorderRadius.circular(AppLayout.borderRadiusMD),
                        border: Border.all(
                          color: _isHovered
                              ? themeController.textPrimaryColor
                                  .withValues(alpha: 0.2)
                              : Colors.transparent,
                          width: 1,
                        ),
                        boxShadow: _isHovered
                            ? [
                                BoxShadow(
                                  color: themeController.isDarkMode
                                      ? Colors.black.withValues(alpha: 0.25)
                                      : Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ]
                            : [],
                      ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppLayout.borderRadiusMD),
                  child: Center(
                    child: ProjectCard.getProjectIcon(widget.project.title),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              widget.project.title,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: AppTypography.font20,
                fontWeight: AppTheme.semiBold,
                color:
                    themeController.textPrimaryColor.withValues(alpha: 0.8),
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            Text(
              widget.project.description,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: AppTypography.font16,
                height: 1.4,
                color: themeController.textSecondaryColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            _buildTechChips(themeController),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final Color cardColor =
        ProjectCard.getColorForProject(widget.project.title);

    return GestureDetector(
      onTap: () =>
          Get.toNamed(AppRoutes.worksDetail, arguments: widget.project),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project icon/image
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppLayout.borderRadiusMD),
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
                  child: Center(
                    child: ProjectCard.getProjectIcon(
                      widget.project.title,
                      size: 40,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Project details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
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

                    Text(
                      widget.project.description,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTypography.font14,
                        height: 1.4,
                        color: themeController.textSecondaryColor,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    _buildTechChips(themeController),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechChips(ThemeController themeController) {
    final techs = widget.project.technologies;
    const int maxVisible = 3;
    final int extra = techs.length - maxVisible;
    final visibleTechs =
        techs.length > maxVisible ? techs.take(maxVisible).toList() : techs;

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        ...visibleTechs.map(
          (tech) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: themeController.borderColor),
            ),
            child: Text(
              tech,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 11,
                color: themeController.textSecondaryColor,
              ),
            ),
          ),
        ),
        if (extra > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: themeController.borderColor),
            ),
            child: Text(
              '+$extra more',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 11,
                color: themeController.textMutedColor,
              ),
            ),
          ),
      ],
    );
  }
}
