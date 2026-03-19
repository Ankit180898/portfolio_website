import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  BlogPostType? _selectedType; // null = All
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<BlogPost> get _filteredPosts {
    var posts = blogPosts.where((post) {
      if (_selectedType != null && post.type != _selectedType) return false;
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      return post.title.toLowerCase().contains(query) ||
          post.description.toLowerCase().contains(query);
    }).toList();
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      return Scaffold(
        backgroundColor: themeController.backgroundColor,
        body: Column(
          children: [
            const NavBar(currentIndex: 1),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: Responsive.isMobile(context)
                        ? MediaQuery.of(context).size.width
                        : AppLayout.maxContentWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.isMobile(context)
                          ? AppLayout.paddingMD
                          : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        _buildHeader(context, themeController),
                        const SizedBox(height: 32),
                        _buildTabs(context, themeController),
                        const SizedBox(height: 32),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("📝 ", style: TextStyle(fontSize: Responsive.isMobile(context) ? 24 : 32)),
            Text(
              "Blog",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.bold,
                fontSize: Responsive.isMobile(context) ? 28 : 36,
                color: themeController.textPrimaryColor.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "My writing and curated reads on Flutter, design, and building products",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: AppTheme.regular,
              fontSize: Responsive.isMobile(context) ? 15 : 18,
              color: themeController.textSecondaryColor,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs(BuildContext context, ThemeController themeController) {
    final tabs = <String, BlogPostType?>{
      'All': null,
      'My Writing': BlogPostType.personal,
      'Curated': BlogPostType.external,
    };

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: tabs.entries.map((entry) {
        final isSelected = _selectedType == entry.value;
        return GestureDetector(
          onTap: () => setState(() => _selectedType = entry.value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? themeController.textPrimaryColor.withValues(alpha: 0.9)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : themeController.textMutedColor.withValues(alpha: 0.35),
                width: 1,
              ),
            ),
            child: Text(
              entry.key,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 14,
                fontWeight: isSelected ? AppTheme.semiBold : AppTheme.medium,
                color: isSelected
                    ? themeController.backgroundColor
                    : themeController.textMutedColor,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSearchBar(BuildContext context, ThemeController themeController) {
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
          FaIcon(Icons.search, color: themeController.textMutedColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              cursorColor: themeController.textPrimaryColor.withValues(alpha: 0.8),
              cursorWidth: 1,
              cursorRadius: const Radius.circular(1),
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                color: themeController.textPrimaryColor.withValues(alpha: 0.8),
                fontSize: 15,
                fontWeight: AppTheme.regular,
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: 'Search posts...',
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
          if (_searchQuery.isNotEmpty) ...[
            const SizedBox(width: 8),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() => _searchQuery = '');
                  _searchController.clear();
                },
                borderRadius: BorderRadius.circular(4),
                splashColor: themeController.textPrimaryColor.withValues(alpha: 0.1),
                highlightColor: themeController.textPrimaryColor.withValues(alpha: 0.05),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FaIcon(Icons.clear, color: themeController.textMutedColor, size: 18),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBlogGrid(BuildContext context, ThemeController themeController) {
    final posts = _filteredPosts;
    final isMobile = MediaQuery.of(context).size.width < AppBreakpoints.md;

    if (posts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Text(
          _searchQuery.isNotEmpty
              ? 'No posts found for "$_searchQuery"'
              : 'No posts here yet.',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            color: themeController.textMutedColor,
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

    const double spacing = 24;
    final double itemWidth =
        (AppLayout.maxContentWidth - spacing) / 2;

    return Wrap(
      spacing: spacing,
      runSpacing: 24,
      children: posts.map((post) {
        return SizedBox(width: itemWidth, child: BlogCard(blogPost: post));
      }).toList(),
    );
  }
}
