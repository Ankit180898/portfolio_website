import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../models/book.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../utils/responsive_helper.dart';
import '../controllers/theme_controller.dart';
import '../config/theme.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: themeController.backgroundColor,
      body: Column(
        children: [
          // Navigation bar
          const NavBar(currentIndex: 2),

          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Responsive.responsiveContainer(
                context: context,
                child: Padding(
                  padding: Responsive.responsivePadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      _buildBookHeader(context, themeController),
                      const SizedBox(height: 40),
                      _buildDivider(),
                      const SizedBox(height: 40),
                      _buildTldrSection(context, themeController),
                      const SizedBox(height: 40),
                      if (book.notes != null && book.notes!.isNotEmpty)
                        _buildNotesSection(context, themeController),
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
  }

  Widget _buildBookHeader(
    BuildContext context,
    ThemeController themeController,
  ) {
    return Column(
      children: [
        // Book cover
        Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildBookCover(),
          ),
        ),
        const SizedBox(height: 32),

        // Book title
        Text(
          book.title,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontWeight: AppTheme.bold,
            fontSize: 36,
            color: themeController.textPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        // Author
        Text(
          'by ${book.author}',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontWeight: AppTheme.regular,
            fontSize: 20,
            color: themeController.textSecondaryColor,
          ),
        ),
        const SizedBox(height: 16),

        // Rating and date
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              book.date,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.regular,
                fontSize: 16,
                color: themeController.textSecondaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '|',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                color: themeController.textSecondaryColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 8),
            FaIcon(Icons.star, size: 16, color: const Color(0xFFFFB800)),
            const SizedBox(width: 4),
            Text(
              book.rating.toString(),
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.regular,
                fontSize: 16,
                color: themeController.textSecondaryColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '|',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                color: themeController.textSecondaryColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '35 min read',
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.regular,
                fontSize: 16,
                color: themeController.textSecondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      width: 100,
      color: Colors.grey.withOpacity(0.2),
    );
  }

  Widget _buildTldrSection(
    BuildContext context,
    ThemeController themeController,
  ) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 800),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color:
            themeController.isDarkMode
                ? const Color(0xFF1E3A29)
                : const Color(0xFFE6F4EA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TL;DR',
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: AppTheme.bold,
                  fontSize: 20,
                  color:
                      themeController.isDarkMode
                          ? Colors.white
                          : const Color(0xFF1E3A29),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.content_copy_outlined,
                  size: 20,
                  color:
                      themeController.isDarkMode
                          ? Colors.white.withOpacity(0.8)
                          : const Color(0xFF1E3A29).withOpacity(0.8),
                ),
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: book.tldrPoints
                          .map((point) => point.text)
                          .join('\n'),
                    ),
                  );
                  Get.snackbar(
                    'Copied to clipboard',
                    'TL;DR points copied to clipboard',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor:
                        themeController.isDarkMode
                            ? const Color(0xFF1E3A29)
                            : const Color(0xFFE6F4EA),
                    colorText:
                        themeController.isDarkMode
                            ? Colors.white
                            : const Color(0xFF1E3A29),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color:
                themeController.isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : const Color(0xFF1E3A29).withOpacity(0.1),
            height: 1,
          ),
          const SizedBox(height: 16),

          // Build TLDR points
          ...book.tldrPoints.map(
            (point) => _buildTldrPoint(
              context,
              point.emoji,
              point.text,
              themeController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTldrPoint(
    BuildContext context,
    String emoji,
    String text,
    ThemeController themeController,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: AppTheme.regular,
                fontSize: 16,
                height: 1.5,
                color:
                    themeController.isDarkMode
                        ? Colors.white.withOpacity(0.9)
                        : const Color(0xFF1E3A29).withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection(
    BuildContext context,
    ThemeController themeController,
  ) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 800),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color:
            themeController.isDarkMode
                ? const Color(0xFF222222)
                : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: AppTheme.bold,
              fontSize: 20,
              color: themeController.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            book.notes!,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: AppTheme.regular,
              fontSize: 16,
              height: 1.6,
              color: themeController.textSecondaryColor,
            ),
          ),
        ],
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
        fit: BoxFit.cover,
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
