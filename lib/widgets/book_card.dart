import 'package:flutter/material.dart';
import '../models/book.dart';
import '../config/theme.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final Function()? onTap;
  final bool isDesktop;

  const BookCard({
    super.key,
    required this.book,
    this.onTap,
    this.isDesktop = true, // Default to desktop view
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive design - determine if we're in mobile/tablet layout
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1200;

    // Use mobile layout if explicitly not desktop or screen is narrow
    final useHorizontalLayout = !isDesktop || isMobile || isTablet;

    if (useHorizontalLayout) {
      return _buildMobileCard(themeController);
    } else {
      return _buildDesktopCard(themeController);
    }
  }

  Widget _buildDesktopCard(ThemeController themeController) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildBookCover(height: 300),
            ),
            const SizedBox(height: 12),

            // Book Title
            Text(
              book.title,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.semiBold,
                fontSize: 18,
                color: themeController.textPrimaryColor,
              ),
              maxLines: 2,
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
            const SizedBox(height: 6),

            // Rating
            Row(
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color:
                      themeController.isDarkMode
                          ? Colors.yellow[700]
                          : Colors.amber,
                ),
                const SizedBox(width: 4),
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
            const SizedBox(height: 4),

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
    );
  }

  Widget _buildMobileCard(ThemeController themeController) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Cover
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 100,
                  height: 150,
                  child: _buildBookCover(height: 150),
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book Title
                    Text(
                      book.title,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: AppTheme.semiBold,
                        fontSize: 20,
                        color: themeController.textPrimaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

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
                    const SizedBox(height: 8),

                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color:
                              themeController.isDarkMode
                                  ? Colors.yellow[700]
                                  : Colors.amber,
                        ),
                        const SizedBox(width: 4),
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
                    const SizedBox(height: 4),

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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookCover({double? height}) {
    // Ensure the image URL is set
    final imageUrl = book.getImageUrl();

    // Use CachedNetworkImage for better performance with network images
    return Hero(
      tag: 'book_${book.title}',
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        width: double.infinity,
        height: height,
        placeholder: (context, url) => _buildLoadingPlaceholder(),
        errorWidget: (context, url, error) => _buildCustomCover(),
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    final themeController = Get.find<ThemeController>();

    return Container(
      width: double.infinity,
      height: 220,
      color:
          themeController.isDarkMode
              ? const Color(0xFF333333)
              : const Color(0xFFEEEEEE),
      child: Center(
        child: CircularProgressIndicator(
          color: themeController.isDarkMode ? Colors.white : Colors.grey[700],
        ),
      ),
    );
  }

  // Instead of a basic placeholder, create a stylized book cover
  Widget _buildCustomCover() {
    Get.find<ThemeController>();

    // Generate a consistent color based on the book title
    final int titleHash = book.title.hashCode;
    final List<Color> coverColors = [
      Colors.blue[300]!,
      Colors.green[300]!,
      Colors.amber[300]!,
      Colors.red[300]!,
      Colors.purple[300]!,
      Colors.teal[300]!,
      Colors.orange[300]!,
      Colors.indigo[300]!,
    ];

    final Color coverColor = coverColors[titleHash.abs() % coverColors.length];
    final Color textColor = Colors.white;

    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: coverColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add author at top
              Text(
                book.author.toUpperCase(),
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),

              // Title in center
              Text(
                book.title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),

              // Add a decorative element
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
