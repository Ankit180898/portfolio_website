import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/blog_post.dart';
import '../widgets/blog_card.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../utils/responsive_helper.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  String _searchQuery = '';

  List<BlogPost> get _filteredPosts {
    if (_searchQuery.isEmpty) {
      return blogPosts;
    }

    return blogPosts.where((post) {
      final title = post.title.toLowerCase();
      final description = post.description.toLowerCase();
      final query = _searchQuery.toLowerCase();

      return title.contains(query) || description.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDarkMode = themeController.isDarkMode;

      return Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF18181B) : Colors.white,
        body: Column(
          children: [
            // Navigation bar
            const NavBar(currentIndex: 1),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width:
                        Responsive.isMobile(context)
                            ? MediaQuery.of(context).size.width
                            : AppLayout.maxContentWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          Responsive.isMobile(context)
                              ? AppLayout.paddingMD
                              : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        _buildHeader(context, themeController),
                        const SizedBox(height: 40),
                        _buildSearchBar(context, themeController),
                        const SizedBox(height: 40),
                        _buildBlogGrid(context, themeController),
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

  Widget _buildHeader(BuildContext context, ThemeController themeController) {
    return Column(
      children: [
        // Title with emoji
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("📝 ", style: TextStyle(fontSize: 32)),
            Text(
              "Blog",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.bold,
                fontSize: 36,
                color: themeController.textPrimaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "A collection of articles on various topics of interest",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: AppTheme.regular,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    ThemeController themeController,
  ) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color:
            themeController.isDarkMode
                ? const Color(
                  0xFF222222,
                ) // Darker color for dark mode search field
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
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              cursorColor: themeController.textPrimaryColor,
              cursorWidth: 1,
              cursorRadius: const Radius.circular(1),
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                color: themeController.textPrimaryColor,
                fontSize: 15,
                fontWeight: AppTheme.regular,
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: 'Search posts, tags...',
                hintStyle: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  color: themeController.textMutedColor,
                  fontSize: 15,
                  fontWeight: AppTheme.regular,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogGrid(BuildContext context, ThemeController themeController) {
    final posts = _filteredPosts;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.md;

    if (posts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            'No posts found matching "$_searchQuery"',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              color: themeController.textMutedColor,
            ),
          ),
        ),
      );
    }

    if (isMobile) {
      return Column(
        spacing: AppConstants.defaultPadding,
        children: posts.map((post) => BlogCard(blogPost: post)).toList(),
      );
    }

    const int columns = 2;
    const double spacing = 24;
    final double gridWidth = AppLayout.maxContentWidth;

    // Calculate item width: (totalWidth - (spacing * (columns-1))) / columns
    final double itemWidth = (gridWidth - (spacing * (columns - 1))) / columns;

    // Desktop/tablet grid layout
    return Wrap(
      spacing: spacing,
      runSpacing: 32,
      children:
          posts.map((post) {
            return SizedBox(width: itemWidth, child: BlogCard(blogPost: post));
          }).toList(),
    );
  }
}
