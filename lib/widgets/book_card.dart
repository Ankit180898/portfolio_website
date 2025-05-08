import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            AspectRatio(
              aspectRatio: 2 / 3, // Standard book cover ratio
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildBookCover(),
              ),
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
                FaIcon(
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
                  child: _buildBookCover(),
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
                        FaIcon(
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

    // First check if URL is empty or invalid
    if (imageUrl.isEmpty || !Uri.parse(imageUrl).isAbsolute) {
      return _buildCustomCover();
    }

    // Use CachedNetworkImage for better performance with network images
    return Hero(
      tag: 'book_${book.title}',
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: height,
        placeholder: (context, url) => _buildLoadingPlaceholder(),
        errorWidget: (context, url, error) {
          print("Error loading image for book ${book.title}: $error");
          return _buildCustomCover();
        },
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    final themeController = Get.find<ThemeController>();

    return Container(
      width: double.infinity,
      height: double.infinity,
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

  // Simplified, guaranteed-to-display custom cover
  Widget _buildCustomCover() {
    // Use a simpler approach to ensure rendering

    // Generate a consistent color based on the book title
    final int titleHash = book.title.hashCode.abs();
    final List<Color> coverColors = [
      Colors.blue[700] ?? Colors.blue,
      Colors.green[700] ?? Colors.green,
      Colors.amber[700] ?? Colors.amber,
      Colors.red[700] ?? Colors.red,
      Colors.purple[700] ?? Colors.purple,
      Colors.teal[700] ?? Colors.teal,
      Colors.orange[700] ?? Colors.orange,
      Colors.indigo[700] ?? Colors.indigo,
    ];

    final Color coverColor = coverColors[titleHash % coverColors.length];
    final Color textColor = Colors.white;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: coverColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Scale text based on available width
          final double titleFontSize = constraints.maxWidth * 0.15;
          final double authorFontSize = constraints.maxWidth * 0.08;

          return Padding(
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
                    fontSize: authorFontSize.clamp(10.0, 14.0),
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: constraints.maxHeight * 0.05),

                // Decorative line
                Container(
                  width: constraints.maxWidth * 0.6,
                  height: 1,
                  color: textColor.withOpacity(0.3),
                ),

                SizedBox(height: constraints.maxHeight * 0.05),

                // Title in center
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Text(
                      book.title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize.clamp(12.0, 24.0),
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                // Bottom decorative element
                Container(
                  width: 40,
                  height: 3,
                  decoration: BoxDecoration(
                    color: textColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                SizedBox(height: constraints.maxHeight * 0.05),

                // Rating stars as a decorative element
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < book.rating.floor()
                          ? Icons.star
                          : Icons.star_border,
                      color: textColor.withOpacity(0.7),
                      size: constraints.maxWidth * 0.08,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
