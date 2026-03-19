import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/projects_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../widgets/project_card.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    final controller = Get.find<ProjectsController>();
    controller.setSearchQuery('');
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectsController>();
    final themeController = Get.find<ThemeController>();
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.md;

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
                    width: isMobile ? width : AppLayout.maxContentWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? AppLayout.paddingMD : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),

                        _buildHeader(context, themeController, isMobile),
                        const SizedBox(height: 40),

                        _buildFilterChips(controller, themeController),
                        const SizedBox(height: 32),

                        _buildSearchBar(controller, themeController),
                        const SizedBox(height: 32),

                        _buildProjects(context, controller),
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

  Widget _buildHeader(
    BuildContext context,
    ThemeController themeController,
    bool isMobile,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '〈',
              style: TextStyle(
                color: themeController.textMutedColor,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '👨‍💻',
              style: TextStyle(fontSize: isMobile ? 24 : 32),
            ),
            const SizedBox(width: 12),
            Text(
              'Works',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 32,
                fontWeight: AppTheme.bold,
                color: themeController.textPrimaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '〉',
              style: TextStyle(
                color: themeController.textMutedColor,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "A showcase of apps, tools, and experiments I've built",
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
          children: controller.filters.map((filter) {
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
                  color: isSelected
                      ? themeController.textPrimaryColor.withValues(alpha: 0.9)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : themeController.textMutedColor
                            .withValues(alpha: 0.35),
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
                    color: isSelected
                        ? themeController.backgroundColor
                        : themeController.textMutedColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildSearchBar(
    ProjectsController controller,
    ThemeController themeController,
  ) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeController.isDarkMode
            ? const Color(0xFF222222)
            : AppTheme.lightSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: themeController.borderColor, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.search, color: themeController.textMutedColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(() {
              return TextField(
                controller: _searchController,
                onChanged: (value) => controller.setSearchQuery(value),
                cursorColor:
                    themeController.textPrimaryColor.withValues(alpha: 0.8),
                cursorWidth: 1,
                cursorRadius: const Radius.circular(1),
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  color:
                      themeController.textPrimaryColor.withValues(alpha: 0.8),
                  fontSize: 15,
                  fontWeight: AppTheme.regular,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: 'Search projects...',
                  hintStyle: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    color: themeController.textMutedColor,
                    fontSize: 15,
                    fontWeight: AppTheme.regular,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14),
                  isDense: true,
                ),
              );
            }),
          ),
          Obx(() {
            if (controller.searchQuery.value.isEmpty) {
              return const SizedBox.shrink();
            }
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.setSearchQuery('');
                      _searchController.clear();
                    },
                    borderRadius: BorderRadius.circular(4),
                    splashColor: themeController.textPrimaryColor
                        .withValues(alpha: 0.1),
                    highlightColor: themeController.textPrimaryColor
                        .withValues(alpha: 0.05),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FaIcon(
                        Icons.clear,
                        color: themeController.textMutedColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProjects(
    BuildContext context,
    ProjectsController controller,
  ) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.md;

    if (isMobile) {
      return _buildProjectsList(controller);
    } else {
      return _buildProjectsGrid(controller);
    }
  }

  Widget _buildProjectsList(ProjectsController controller) {
    return Obx(() {
      final projects = controller.filteredProjects;

      if (projects.isEmpty) {
        return _buildEmpty(controller);
      }

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

  Widget _buildProjectsGrid(ProjectsController controller) {
    return Obx(() {
      final projects = controller.filteredProjects;

      if (projects.isEmpty) {
        return _buildEmpty(controller);
      }

      const int columns = 3;
      const double spacing = 24;
      final double gridWidth = AppLayout.maxContentWidth;
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

  Widget _buildEmpty(ProjectsController controller) {
    final themeController = Get.find<ThemeController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Text(
        controller.searchQuery.value.isNotEmpty
            ? 'No projects found for "${controller.searchQuery.value}"'
            : 'No projects here yet.',
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          color: themeController.textMutedColor,
        ),
      ),
    );
  }
}
