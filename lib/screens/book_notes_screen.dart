import 'package:flutter/material.dart';
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
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.md;

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
                    width: isMobile ? width : AppLayout.maxContentWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? AppLayout.paddingMD : 0,
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
                        _buildBooksGrid(context),

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
    return Column(
      children: [
        // Title with emoji
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://www.svgrepo.com/show/138319/open-book.svg',
              width: 40,
              height: 40,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Text("📚 ", style: TextStyle(fontSize: 32)),
            ),
            const SizedBox(width: 12),
            Text(
              "Book Notes",
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
            "A personal library of my key takeaways, notes, & highlights from the books I've read",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: AppTheme.regular,
              fontSize: 18,
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

  Widget _buildBooksGrid(BuildContext context) {
    final bookList = _filteredBooks;
    final isMobile = MediaQuery.of(context).size.width < AppBreakpoints.md;

    if (bookList.isEmpty) {
      final themeController = Get.find<ThemeController>();
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

    if (isMobile) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: BookCard(
              book: bookList[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BookDetailScreen(book: bookList[index]),
                  ),
                );
              },
            ),
          );
        },
      );
    } else {
      final double gridWidth = AppLayout.maxContentWidth;
      const int columns = 3;
      const double spacing = 20;

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
