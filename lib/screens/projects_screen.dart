import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/widgets/project_card.dart';
import '../controllers/projects_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectsController>();
    final themeController = Get.find<ThemeController>();
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.md;

    // Wrap the entire screen in Obx to listen for theme changes
    return Obx(() {
      final isDarkMode = themeController.isDarkMode;

      return Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF18181B) : Colors.white,
        body: Column(
          children: [
            // Navigation bar
            const NavBar(currentIndex: 0),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: isMobile ? width : AppLayout.maxContentWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? AppLayout.paddingMD : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),

                        // Header
                        _buildHeader(themeController),
                        const SizedBox(height: 60),
                        // Header
                        _buildFilterChips(controller, themeController),
                        const SizedBox(height: 60),

                        // Projects grid or list
                        _buildProjects(context, controller),
                        const SizedBox(height: 80),

                        // Footer
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

  Widget _buildHeader(ThemeController themeController) {
    return Column(
      children: [
        // Title with emoji and angle brackets
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left arrow
            Text(
              "›",
              style: TextStyle(
                color: themeController.textMutedColor,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(width: 8),

            // Emoji with briefcase
            const Text("👨‍💻", style: TextStyle(fontSize: 32)),
            const SizedBox(width: 12),

            // Works text
            Text(
              "Works",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 48,
                fontWeight: AppTheme.bold,
                color: themeController.textPrimaryColor,
              ),
            ),
            const SizedBox(width: 8),

            // Right arrow
            Text(
              "‹",
              style: TextStyle(
                color: themeController.textMutedColor,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Description
        Text(
          "A collection of links to my current & previous works and projects",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 18,
            fontWeight: AppTheme.regular,
            color: themeController.textMutedColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips(
    ProjectsController controller,
    ThemeController themeController,
  ) {
    return Obx(() {
      return Container(
        alignment: Alignment.center,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children:
              controller.filters.map((filter) {
                final isSelected = controller.activeFilter.value == filter;

                return InkWell(
                  onTap: () => controller.setFilter(filter),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? themeController.textMutedColor
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color:
                            isSelected
                                ? Colors.transparent
                                : themeController.textMutedColor.withOpacity(
                                  0.3,
                                ),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: 14,
                        fontWeight:
                            isSelected ? AppTheme.semiBold : AppTheme.medium,
                        color:
                            isSelected
                                ? Colors.white
                                : themeController.textPrimaryColor.withOpacity(
                                  0.8,
                                ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      );
    });
  }

  Widget _buildProjects(BuildContext context, ProjectsController controller) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.md;

    // Use list view for mobile and grid for desktop
    if (isMobile) {
      return _buildProjectsList(controller);
    } else {
      return _buildProjectsGrid(context, controller);
    }
  }

  Widget _buildProjectsList(ProjectsController controller) {
    return Obx(() {
      final projects = controller.filteredProjects;

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: projects.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      );
    });
  }

  Widget _buildProjectsGrid(
    BuildContext context,
    ProjectsController controller,
  ) {
    return Obx(() {
      final projects = controller.filteredProjects;

      // Always use exactly 3 columns for consistency with navbar width
      const int columns = 3;
      const double spacing = 24;
      final double gridWidth = AppLayout.maxContentWidth;

      // Calculate item width: (totalWidth - (spacing * (columns-1))) / columns
      final double itemWidth =
          (gridWidth - (spacing * (columns - 1))) / columns;

      return Wrap(
        spacing: spacing,
        runSpacing: 40,
        alignment: WrapAlignment.start,
        children: List.generate(projects.length, (index) {
          return SizedBox(
            width: itemWidth,
            child: ProjectCard(project: projects[index]),
          );
        }),
      );
    });
  }
}
