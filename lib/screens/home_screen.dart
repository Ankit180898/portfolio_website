import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/models/project.dart';
import '../widgets/project_card.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../controllers/projects_controller.dart';
import '../controllers/theme_controller.dart';
import '../config/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/theme.dart';
import '../widgets/blog_card.dart';
import '../models/blog_post.dart';
import '../config/constants.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projectsController = Get.put(ProjectsController());
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.md;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const NavBar(currentIndex: -1),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                          width < AppBreakpoints.md
                              ? width
                              : AppLayout.maxContentWidth,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            width < AppBreakpoints.md ? AppLayout.paddingMD : 0,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            isMobile
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60),
                          _buildHeroSection(context, isMobile),
                          const SizedBox(height: 80),
                          _buildSectionHeader(
                            context,
                            "WORKS",
                            AppRoutes.works,
                          ),
                          const SizedBox(height: 40),
                          _buildProjectsGrid(context, projectsController),
                          const SizedBox(height: 80),
                          _buildSectionHeader(
                            context,
                            "LATEST BLOG POSTS",
                            AppRoutes.blog,
                          ),
                          const SizedBox(height: 40),
                          _buildBlogPostsSection(context),
                          const SizedBox(height: 80),
                          const Footer(),
                          const SizedBox(height: 20), // Add padding at bottom
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    final theme = Theme.of(context);

    // For mobile, use stacked layout (vertical)
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(),
          const SizedBox(height: 32),
          _buildGreeting(context, theme),
        ],
      );
    }

    // Desktop layout - horizontal with image on left, text on right
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        const SizedBox(width: 40),
        Expanded(child: _buildGreeting(context, theme)),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF7DE8B3), // Mint green background
        image: const DecorationImage(
          image: AssetImage('assets/images/profile_portrait.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, ThemeData theme) {
    final themeController = Get.find<ThemeController>();
    final isMobile = MediaQuery.of(context).size.width < AppBreakpoints.md;

    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hi",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 32,
                fontWeight: AppTheme.bold,
                color: themeController.textPrimaryColor,
                letterSpacing: -1.0,
              ),
            ),
            const SizedBox(width: 8),
            const Text("👋", style: TextStyle(fontSize: 32)),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "I'm Ankit, a Flutter Developer & UI/UX Designer.",
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 18,
            height: 1.5,
            color: themeController.textSecondaryColor,
            fontWeight: AppTheme.medium,
            letterSpacing: 0.5,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 8),
        Text(
          "Currently building beautiful mobile experiences.",
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 18,
            height: 1.5,
            color: themeController.textSecondaryColor,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 24),
        isMobile
            ? Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _launchEmail("ankit.me180898@gmail.com"),
                    icon: const FaIcon(FontAwesomeIcons.envelope, size: 16),
                    label: Text(
                      "Say hello!",
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 14,
                        fontWeight: AppTheme.medium,
                        color: themeController.textPrimaryColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: themeController.textPrimaryColor,
                      elevation: 0,

                      side: BorderSide(color: themeController.textPrimaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () => _downloadCV(),
                    icon: const FaIcon(
                      FontAwesomeIcons.fileArrowDown,
                      size: 16,
                    ),
                    label: Text(
                      "Download CV",
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 14,
                        fontWeight: AppTheme.medium,
                        color: themeController.textPrimaryColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: themeController.textPrimaryColor,
                      foregroundColor: themeController.textPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
            : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _launchEmail("ankit.me180898@gmail.com"),
                  icon: const FaIcon(FontAwesomeIcons.envelope, size: 16),
                  label: Text(
                    "Say hello!",
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: AppTheme.medium,
                      color: themeController.textPrimaryColor,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: themeController.textPrimaryColor,
                    side: BorderSide(color: themeController.textPrimaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () => _downloadCV(),
                  icon: const FaIcon(FontAwesomeIcons.fileArrowDown, size: 16),
                  label: Text(
                    "Download CV",
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 14,
                      fontWeight: AppTheme.medium,
                      color: themeController.textPrimaryColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: themeController.textPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String route) {
    final themeController = Get.find<ThemeController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 14,
            fontWeight: AppTheme.medium,
            letterSpacing: 1.2,
            color: themeController.textMutedColor,
          ),
        ),
        Expanded(
          child: Container(
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomPaint(
              painter: DottedLinePainter(color: themeController.textMutedColor),
              size: const Size(double.infinity, 1),
            ),
          ),
        ),
        TextButton(
          onPressed: () => Get.toNamed(route),
          style: TextButton.styleFrom(
            foregroundColor: themeController.textMutedColor,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "View all",
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 14,
              fontWeight: AppTheme.regular,
              color: themeController.textMutedColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsGrid(
    BuildContext context,
    ProjectsController controller,
  ) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.md;
    final isTablet = width < AppBreakpoints.lg && !isMobile;

    return Obx(() {
      final featuredProjects = controller.featuredProjects;
      final displayProjects = featuredProjects.take(3).toList();

      // For mobile, show as a vertical list (ListTile style)
      if (isMobile) {
        return Column(
          children:
              displayProjects
                  .map(
                    (project) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildProjectListTile(context, project),
                    ),
                  )
                  .toList(),
        );
      }

      // For tablet and desktop
      return LayoutBuilder(
        builder: (context, constraints) {
          final columnCount = isTablet ? 2 : 3;
          final spacing = isTablet ? 24.0 : 48.0;
          final itemWidth =
              (constraints.maxWidth - (spacing * (columnCount - 1))) /
              columnCount;

          return Wrap(
            spacing: 24,
            runSpacing: 32,
            children:
                displayProjects.map((project) {
                  return SizedBox(
                    width: itemWidth,
                    height: 280, // Fixed height for consistent look
                    child: ProjectCard(project: project),
                  );
                }).toList(),
          );
        },
      );
    });
  }

  Widget _buildProjectListTile(BuildContext context, Project project) {
    final themeController = Get.find<ThemeController>();
    final projectsController = Get.find<ProjectsController>();
    final Color cardColor = _getColorForProject(project.title);

    return InkWell(
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      onTap: () => projectsController.openProject(project),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon/avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: _getProjectIcon(project.title, size: 40)),
          ),
          const SizedBox(width: 16),
          // Title, badge, and description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: AppTheme.bold,
                          fontSize: 18,
                          color: themeController.textPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  project.description,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 15,
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

  // Helper to get color for project
  Color _getColorForProject(String title) {
    switch (title) {
      case "Spendify":
        return const Color(0xFF8BC34A);
      case "Flutter Stack":
        return const Color(0xFF4169E1);
      case "Artworks":
        return const Color(0xFFFF4081);
      case "Brainfish":
        return const Color(0xFFB3E141);
      case "Layers":
        return const Color(0xFF121212);
      case "Background Remover":
        return const Color(0xFF039BE5);
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

  // Helper to get icon for project
  Widget _getProjectIcon(String title, {double size = 32}) {
    switch (title) {
      case "Spendify":
        return FaIcon(FontAwesomeIcons.wallet, size: size, color: Colors.white);
      case "Flutter Stack":
        return FaIcon(FontAwesomeIcons.code, size: size, color: Colors.white);
      case "Artworks":
        return FaIcon(
          FontAwesomeIcons.paintBrush,
          size: size,
          color: Colors.white,
        );
      case "Brainfish":
        return FaIcon(FontAwesomeIcons.fish, size: size, color: Colors.white);
      case "Layers":
        return FaIcon(
          FontAwesomeIcons.layerGroup,
          size: size,
          color: Colors.white,
        );
      case "Notion Icons 3D":
        return Text(
          "n.",
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      default:
        return FaIcon(FontAwesomeIcons.box, size: size, color: Colors.white);
    }
  }

  Widget _buildBlogPostsSection(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.md;

    final displayPosts = blogPosts.take(2).toList();

    if (isMobile) {
      return Column(
        children:
            displayPosts
                .map(
                  (post) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: BlogCard(blogPost: post),
                  ),
                )
                .toList(),
      );
    }

    // Desktop layout with equal height columns
    return LayoutBuilder(
      builder: (context, constraints) {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: BlogCard(blogPost: displayPosts[0])),
              const SizedBox(width: 24),
              Expanded(child: BlogCard(blogPost: displayPosts[1])),
            ],
          ),
        );
      },
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'ankit.me180898@gmail.com',
      query: 'subject=Hello!',
    );

    try {
      if (!await launchUrl(emailUri)) {
        throw Exception('Could not launch $emailUri');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
      // You could show a snackbar here to notify the user
    }
  }

  Future<void> _downloadCV() async {
    // Replace with your actual CV URL
    const cvUrl =
        'https://drive.google.com/file/d/1lZJz7b190mjf756-wTrnKvPTAS4o8wPz/view?usp=drive_link';
    final Uri uri = Uri.parse(cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

// Custom painter for dotted line
class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.round;

    const double dashWidth = 4;
    const double dashSpace = 4;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
