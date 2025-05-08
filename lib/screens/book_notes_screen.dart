import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import 'book_detail_screen.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';
import '../config/constants.dart';

class BookNotesScreen extends StatefulWidget {
  const BookNotesScreen({super.key});

  @override
  State<BookNotesScreen> createState() => _BookNotesScreenState();
}

class _BookNotesScreenState extends State<BookNotesScreen> {
  String _searchQuery = '';

  List<Book> get _filteredBooks {
    if (_searchQuery.isEmpty) {
      return books;
    }

    return books.where((book) {
      final title = book.title.toLowerCase();
      final author = book.author.toLowerCase();
      final query = _searchQuery.toLowerCase();

      return title.contains(query) || author.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive design breakpoints
    final isMobile = screenWidth < AppBreakpoints.md;
    final isTablet =
        screenWidth >= AppBreakpoints.md && screenWidth < AppBreakpoints.lg;
    final isDesktop = screenWidth >= AppBreakpoints.lg;

    return Obx(
      () => Scaffold(
        backgroundColor: themeController.backgroundColor,
        body: Column(
          children: [
            // Navigation bar
            const NavBar(currentIndex: 2),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: isMobile ? screenWidth : AppLayout.maxContentWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          isMobile
                              ? AppLayout.paddingMD
                              : isTablet
                              ? AppLayout.paddingSM
                              : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Header section
                        const SizedBox(height: 40),
                        _buildHeader(context, themeController),
                        const SizedBox(height: 40),

                        // Search bar
                        _buildSearchBar(context, themeController),
                        const SizedBox(height: 40),

                        // Books grid
                        _buildBooksGrid(context, isMobile, isTablet, isDesktop),

                        // Footer
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeController themeController) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.md;

    return Column(
      children: [
        // Title with emoji
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://www.svgrepo.com/show/138319/open-book.svg',
              width: isMobile ? 32 : 40,
              height: isMobile ? 32 : 40,
              errorBuilder:
                  (context, error, stackTrace) => Text(
                    "📚 ",
                    style: TextStyle(fontSize: isMobile ? 28 : 32),
                  ),
            ),
            const SizedBox(width: 12),
            Text(
              "Book Notes",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.bold,
                fontSize: isMobile ? 28 : 36,
                color: themeController.textPrimaryColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
          child: Text(
            "A personal library of my key takeaways, notes, & highlights from the books I've read",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: AppTheme.regular,
              fontSize: isMobile ? 16 : 18,
              color: themeController.textSecondaryColor,
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
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              cursorColor: themeController.textPrimaryColor.withOpacity(0.8),
              cursorWidth: 1,
              cursorRadius: const Radius.circular(1),
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                color: themeController.textPrimaryColor.withOpacity(0.8),
                fontSize: 15,
                fontWeight: AppTheme.regular,
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: 'Search books by title, author, or genre',
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

  Widget _buildBooksGrid(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    final bookList = _filteredBooks;
    final themeController = Get.find<ThemeController>();

    if (bookList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            'No books found matching "$_searchQuery"',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              color: themeController.textMutedColor,
            ),
          ),
        ),
      );
    }

    // Use ListView for mobile and tablet
    if (isMobile || isTablet) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          return BookCard(
            book: bookList[index],
            isDesktop: false, // Set to false for mobile/tablet layout
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: bookList[index]),
                ),
              );
            },
          );
        },
      );
    } else {
      // Desktop grid view
      final double gridWidth = AppLayout.maxContentWidth;
      int columns = 3;

      // Adjust columns based on screen width for better responsiveness
      if (MediaQuery.of(context).size.width < AppBreakpoints.xl) {
        columns = 2;
      }

      const double spacing = 24;
      final double itemWidth =
          (gridWidth - (spacing * (columns - 1))) / columns;

      return Wrap(
        spacing: spacing,
        runSpacing: 40,
        children:
            bookList.map((book) {
              return SizedBox(
                width: itemWidth,
                child: BookCard(
                  book: book,
                  isDesktop: true, // Set to true for desktop layout
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
      );
    }
  }
}
