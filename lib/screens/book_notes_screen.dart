import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../utils/responsive_helper.dart';
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

    return Obx(()=>
    
       Scaffold(
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
                        _buildBooksGrid(context, themeController),
      
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
    ThemeController themeController,
  ) {
    final bookList = _filteredBooks;
    final isMobile = MediaQuery.of(context).size.width < AppBreakpoints.md;

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

    if (isMobile) {
      // List view for mobile in horizontal row style
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          return _buildMobileBookItem(
            context,
            bookList[index],
            themeController,
          );
        },
      );
    } else {
      // For desktop, we always use exactly 3 columns with equal spacing
      // Use Grid layout with fixed item width based on navbar width
      final double gridWidth = AppLayout.maxContentWidth;
      const int columns = 3;
      const double spacing = 24;

      // Calculate item width: (totalWidth - (spacing * (columns-1))) / columns
      final double itemWidth =
          (gridWidth - (spacing * (columns - 1))) / columns;

      return Wrap(
        spacing: spacing,
        runSpacing: 40,
        children:
            bookList.map((book) {
              return SizedBox(
                width: itemWidth,
                child: _buildDesktopBookCard(context, book, themeController),
              );
            }).toList(),
      );
    }
  }

  Widget _buildDesktopBookCard(
    BuildContext context,
    Book book,
    ThemeController themeController,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(book: book),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: themeController.isDarkMode
                  ? const Color(0xFF333333)
                  : const Color(0xFFEEEEEE),
              child: AspectRatio(
                aspectRatio: 0.7,
                child: Image.network(
                  book.getImageUrl(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholder(book);
                  },
                ),
              ),
            ),
          ),


            const SizedBox(height: 14),

            // Book title
            Text(
              book.title,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.semiBold,
                fontSize: 16,
                color: themeController.textPrimaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Author
            Text(
              'by ${book.author}',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.regular,
                fontSize: 14,
                color: themeController.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 8),

            // Rating stars
            Row(
              children: [
                ...List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Icon(
                      Icons.star,
                      size: 14,
                      color:
                          index < book.rating
                              ? const Color(0xFFFFB800)
                              : themeController.isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  book.rating.toString(),
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: AppTheme.medium,
                    fontSize: 14,
                    color: themeController.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Date
            Text(
              book.date,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.regular,
                fontSize: 13,
                color: themeController.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileBookItem(
    BuildContext context,
    Book book,
    ThemeController themeController,
  ) {
    // Check if the book has an image, if not use the banner style from the reference
    final bool hasImage = book.bookLink != null && book.bookLink!.isNotEmpty;

    if (!hasImage) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailScreen(book: book),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBannerPlaceholder(book, themeController),
                const SizedBox(height: 16),

                Text(
                  book.title,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: AppTheme.bold,
                    fontSize: 20,
                    color: themeController.textPrimaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                Text(
                  'by ${book.author}',
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: AppTheme.regular,
                    fontSize: 16,
                    color: themeController.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        size: 18,
                        color:
                            index < book.rating
                                ? const Color(0xFFFFB800)
                                : themeController.isDarkMode
                                ? Colors.grey[800]
                                : Colors.grey[300],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      book.rating.toString(),
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: AppTheme.medium,
                        fontSize: 16,
                        color: themeController.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Text(
                  book.date,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: AppTheme.regular,
                    fontSize: 14,
                    color: themeController.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Standard row layout with image
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(book: book),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Cover
              ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 120,
                height: 180,
                color: themeController.isDarkMode
                    ? const Color(0xFF333333)
                    : const Color(0xFFEEEEEE),
                child: Image.network(
                  book.getImageUrl(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholder(book);
                  },
                ),
              ),
            ),
              const SizedBox(width: 16),

              // Book Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        book.title,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: AppTheme.bold,
                          fontSize: 20,
                          color: themeController.textPrimaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Author
                      Text(
                        'by ${book.author}',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: AppTheme.regular,
                          fontSize: 16,
                          color: themeController.textSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Star rating
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              size: 18,
                              color:
                                  index < book.rating
                                      ? const Color(0xFFFFB800)
                                      : themeController.isDarkMode
                                      ? Colors.grey[800]
                                      : Colors.grey[300],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            book.rating.toString(),
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: AppTheme.medium,
                              fontSize: 16,
                              color: themeController.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Date
                      Text(
                        book.date,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: AppTheme.regular,
                          fontSize: 14,
                          color: themeController.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build banner placeholder for books without images (mobile view)
  Widget _buildBannerPlaceholder(Book book, ThemeController themeController) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color:
            themeController.isDarkMode
                ? const Color(0xFF333333)
                : const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                book.title,
                style: TextStyle(
                  color: themeController.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'by ${book.author}',
                style: TextStyle(
                  color: themeController.textSecondaryColor,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(Book book) {
    // Create a placeholder with title and author
    final themeController = Get.find<ThemeController>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              book.title,
              style: TextStyle(
                color: themeController.textPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              'by ${book.author}',
              style: TextStyle(
                color: themeController.textSecondaryColor,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
