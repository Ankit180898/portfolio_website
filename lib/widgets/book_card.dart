import 'package:flutter/material.dart';
import '../models/book.dart';
import '../config/theme.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final Function()? onTap;

  const BookCard({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildBookCover(context),
            ),
            const SizedBox(height: 16),

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
            const SizedBox(height: 8),

            // Rating
            Row(
              children: [
                Text(
                  book.rating.toString(),
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: AppTheme.medium,
                    fontSize: 14,
                    color: themeController.textSecondaryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.star,
                  size: 16,
                  color:
                      themeController.isDarkMode
                          ? Colors.yellow[700]
                          : Colors.amber,
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
    );
  }

  Widget _buildBookCover(BuildContext context) {
    // Ensure we have an image URL
    if (book.imageUrl == null || book.imageUrl!.isEmpty) {
      book.imageUrl = book.getImageUrl();
    }

    // Use CachedNetworkImage for better performance with network images
    return Hero(
      tag: book.title,
      child: CachedNetworkImage(
        imageUrl: book.imageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.25,
        placeholder: (context, url) => _buildLoadingPlaceholder(),
        errorWidget: (context, url, error) => _buildPlaceholder(),
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

  Widget _buildPlaceholder() {
    // Create a placeholder with title and author
    final themeController = Get.find<ThemeController>();

    return Container(
      width: double.infinity,
      height: 220,
      color:
          themeController.isDarkMode
              ? const Color(0xFF333333)
              : const Color(0xFFEEEEEE),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                book.title,
                style: TextStyle(
                  color:
                      themeController.isDarkMode
                          ? Colors.white
                          : themeController.textPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                'by ${book.author}',
                style: TextStyle(
                  color:
                      themeController.isDarkMode
                          ? Colors.white70
                          : themeController.textSecondaryColor,
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
}
