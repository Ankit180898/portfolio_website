import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;
import '../models/project.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Project project = Get.arguments as Project;
    final themeController = Get.find<ThemeController>();
    final isMobile = MediaQuery.of(context).size.width < AppBreakpoints.md;

    return Obx(() {
      return Scaffold(
        backgroundColor: themeController.backgroundColor,
        body: Column(
          children: [
            const NavBar(currentIndex: 0),
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
                        _buildHeroBanner(project, themeController, isMobile),
                        const SizedBox(height: 28),
                        _buildTypeBadge(project),
                        const SizedBox(height: 16),
                        _buildTitle(project, themeController),
                        const SizedBox(height: 16),
                        _buildDateRow(project, themeController),
                        const SizedBox(height: 28),
                        _buildDescription(project, themeController),
                        const SizedBox(height: 40),
                        _buildTechStack(project, themeController),
                        const SizedBox(height: 48),
                        _buildCta(project, themeController),
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
            'Back to Works',
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

  Widget _buildHeroBanner(
    Project project,
    ThemeController themeController,
    bool isMobile,
  ) {
    final cardColor = _colorForProject(project.title);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppLayout.borderRadiusMD),
      child: AspectRatio(
        aspectRatio: isMobile ? 2 : 3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            project.title == "Notion Icons 3D"
                ? Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFFA07A),
                          Color(0xFFFF00A0),
                          Color(0xFF9370DB),
                        ],
                      ),
                    ),
                  )
                : Container(color: cardColor),
            CustomPaint(
              painter: _DiagonalLines(
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
            Center(
              child: ProjectCard.getProjectIcon(
                project.title,
                size: isMobile ? 48 : 64,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge(Project project) {
    final Color badgeColor;
    final String badgeLabel;

    switch (project.type) {
      case ProjectType.app:
        badgeColor = const Color(0xFF6366F1);
        badgeLabel = 'App';
        break;
      case ProjectType.web:
        badgeColor = const Color(0xFF0EA5E9);
        badgeLabel = 'Web';
        break;
      case ProjectType.design:
        badgeColor = const Color(0xFF8B5CF6);
        badgeLabel = 'Design';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        badgeLabel,
        style: TextStyle(
          color: badgeColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildTitle(Project project, ThemeController themeController) {
    return Text(
      project.title,
      style: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontSize: 32,
        fontWeight: AppTheme.bold,
        color: themeController.textPrimaryColor,
        height: 1.25,
      ),
    );
  }

  Widget _buildDateRow(Project project, ThemeController themeController) {
    return Row(
      children: [
        Text(
          project.type.name.toUpperCase(),
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 14,
            color: themeController.textMutedColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '·',
            style: TextStyle(color: themeController.textMutedColor),
          ),
        ),
        Text(
          '${project.technologies.length} technologies',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 14,
            color: themeController.textMutedColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(Project project, ThemeController themeController) {
    return Text(
      project.description,
      style: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontSize: AppTypography.font16,
        height: 1.75,
        color: themeController.textSecondaryColor,
      ),
    );
  }

  Widget _buildTechStack(Project project, ThemeController themeController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tech Stack',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 22,
            fontWeight: AppTheme.bold,
            color: themeController.textPrimaryColor,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: themeController.borderColor),
              ),
              child: Text(
                tech,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 13,
                  color: themeController.textSecondaryColor,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCta(Project project, ThemeController themeController) {
    final bool hasLive = project.liveLink != null;
    final bool hasGitHub = project.githubLink != null;

    if (!hasLive && !hasGitHub) return const SizedBox.shrink();

    final isDark = themeController.isDarkMode;

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
                  hasLive ? 'Check it out' : 'View on GitHub',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 16,
                    fontWeight: AppTheme.semiBold,
                    color: themeController.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasLive
                      ? 'See the live project in action.'
                      : 'Browse the full source code.',
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasLive) ...[
                GestureDetector(
                  onTap: () => _launchUrl(project.liveLink!),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: themeController.textPrimaryColor,
                      borderRadius:
                          BorderRadius.circular(AppLayout.borderRadiusMD),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.arrowUpRightFromSquare,
                          size: 13,
                          color: themeController.backgroundColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Live Site',
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
              if (hasLive && hasGitHub) const SizedBox(width: 12),
              if (hasGitHub) ...[
                GestureDetector(
                  onTap: () => _launchUrl(project.githubLink!),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                          BorderRadius.circular(AppLayout.borderRadiusMD),
                      border: Border.all(color: themeController.borderColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.github,
                          size: 14,
                          color: themeController.textPrimaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'GitHub',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: 14,
                            fontWeight: AppTheme.semiBold,
                            color: themeController.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
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

  Color _colorForProject(String title) {
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
