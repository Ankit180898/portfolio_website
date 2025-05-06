import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/controllers/home_controller.dart';
import 'package:portfolio_website/widgets/custom_button.dart';
import 'package:portfolio_website/widgets/dotted_line.dart';
import 'package:portfolio_website/widgets/project_card.dart';
import 'package:portfolio_website/widgets/nav_bar.dart';
import 'package:portfolio_website/widgets/footer.dart';
import 'package:portfolio_website/controllers/projects_controller.dart';
import 'package:portfolio_website/controllers/theme_controller.dart';
import 'package:portfolio_website/config/routes.dart';
import 'package:portfolio_website/config/theme.dart';
import 'package:portfolio_website/widgets/blog_card.dart';
import 'package:portfolio_website/models/blog_post.dart';
import 'package:portfolio_website/config/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
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
                      maxWidth: isMobile ? width : AppLayout.maxContentWidth,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? AppLayout.paddingMD : 0,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            isMobile
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60),
                          _buildHeroSection(context, isMobile, homeController),
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
                          const SizedBox(height: 20),
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

  Widget _buildHeroSection(
    BuildContext context,
    bool isMobile,
    HomeController homeController,
  ) {
    final themeController = Get.find<ThemeController>();

    final content = Column(
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
          maxLines: 2,
        ),
        const SizedBox(height: 24),
        _buildActionButtons(context, themeController, isMobile, homeController),
      ],
    );

    return isMobile
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildAvatar(), const SizedBox(height: 32), content],
        )
        : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAvatar(),
            const SizedBox(width: 40),
            Expanded(child: content),
          ],
        );
  }

  Widget _buildAvatar() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF7DE8B3),
        image: const DecorationImage(
          image: AssetImage('assets/images/profile_portrait.jpeg'),
          fit: BoxFit.cover,
          alignment: Alignment(0, -1),
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    ThemeController themeController,
    bool isMobile,
    HomeController homeController,
  ) {
    final buttons = [
      buildButton(
        context,
        icon: FontAwesomeIcons.envelope,
        label: "Say hello!",
        onPressed: () => homeController.launchEmail("ankit.me180898@gmail.com"),
        isPrimary: true,
        isDark: themeController.isDarkMode,
      ),
      const SizedBox(width: 16),
      buildButton(
        context,
        icon: FontAwesomeIcons.download,
        label: "Download CV",
        onPressed: () => homeController.downloadResume(AppConstants.resumeUrl),
        isPrimary: false,
        isDark: themeController.isDarkMode,
      ),
    ];

    return isMobile
        ? Center(child: Row(mainAxisSize: MainAxisSize.min, children: buttons))
        : Row(mainAxisSize: MainAxisSize.min, children: buttons);
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
          child: CustomPaint(
            painter: DottedLinePainter(color: themeController.textMutedColor),
            size: const Size(double.infinity, 1),
          ).paddingSymmetric(horizontal: 16),
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
      final featuredProjects = controller.featuredProjects.take(3).toList();

      if (featuredProjects.isEmpty) {
        return const Center(child: Text("No projects available"));
      }

      if (isMobile) {
        return Column(
          children:
              featuredProjects
                  .map((project) => ProjectCard(project: project))
                  .toList(),
        );
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          final columnCount = isTablet ? 2 : 3;
          final spacing = isTablet ? 24.0 : 48.0;
          final itemWidth =
              (constraints.maxWidth - (spacing * (columnCount - 1))) /
              columnCount;

          return Wrap(
            spacing: spacing,
            runSpacing: 32,
            children:
                featuredProjects
                    .map(
                      (project) => SizedBox(
                        width: itemWidth,
                        height: 280,
                        child: ProjectCard(project: project),
                      ),
                    )
                    .toList(),
          );
        },
      );
    });
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

  // Future<void> _launchEmail(String email) async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: 'ankit.me180898@gmail.com',
  //     query: 'subject=Hello!',
  //   );

  //   try {
  //     if (!await launchUrl(emailUri)) {
  //       throw Exception('Could not launch $emailUri');
  //     }
  //   } catch (e) {
  //     debugPrint('Error launching email: $e');
  //     // You could show a snackbar here to notify the user
  //   }
  // }

  // Future<void> _downloadCV() async {
  //   // Replace with your actual CV URL
  //   const cvUrl =
  //       'https://drive.google.com/file/d/1lZJz7b190mjf756-wTrnKvPTAS4o8wPz/view?usp=drive_link';
  //   final Uri uri = Uri.parse(cvUrl);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   }
  // }
}
