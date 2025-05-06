import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../config/constants.dart';
import '../config/routes.dart';
import '../config/theme.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;

  const NavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < AppBreakpoints.md;
    final ThemeController controller = Get.find<ThemeController>();

    // Use Obx to listen to theme changes
    return Obx(() {
      final isDark = controller.isDarkMode;
      debugPrint('NavBar rebuilding with isDarkMode = $isDark');

      if (isMobile) {
        return _buildMobileNav(context, controller, isDark);
      }

      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
          child: Container(
            width: 708,
            height: 56,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            decoration: BoxDecoration(
              // Force specific colors based on theme mode
              color: isDark ? const Color(0xFF27272A) : const Color(0xFFF4F4F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Logo
                _buildLogo(controller, isDark),

                // Spacer
                const Spacer(flex: 1),

                // Navigation Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNavItem(
                      'works',
                      0,
                      AppRoutes.works,
                      controller,
                      isDark,
                    ),
                    const SizedBox(width: 28),
                    _buildNavItem(
                      'blog',
                      1,
                      AppRoutes.blog,
                      controller,
                      isDark,
                    ),
                    const SizedBox(width: 28),
                    _buildNavItem(
                      'book notes',
                      2,
                      AppRoutes.bookNotes,
                      controller,
                      isDark,
                    ),
                    const SizedBox(width: 28),
                    _buildNavItem(
                      'resources',
                      3,
                      AppRoutes.resources,
                      controller,
                      isDark,
                    ),
                    const SizedBox(width: 28),
                    _buildNavItem(
                      'about',
                      4,
                      AppRoutes.about,
                      controller,
                      isDark,
                    ),
                    const SizedBox(width: 28),
                    _buildNavItem('now', 5, AppRoutes.now, controller, isDark),
                    const SizedBox(width: 28),
                    _buildThemeToggle(controller, isDark),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildMobileNav(
    BuildContext context,
    ThemeController controller,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Container(
          width: 320,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF27272A) : const Color(0xFFF4F4F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Logo
              _buildLogo(controller, isDark),

              // Spacer
              const Spacer(),

              // Menu Button
              IconButton(
                onPressed: () => _showMobileMenu(context, controller),
                icon: Icon(
                  Icons.menu,
                  size: 24,
                  color:
                      isDark
                          ? AppTheme.darkTextPrimary
                          : const Color(0xFF27272A),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(ThemeController controller, bool isDark) {
    final logoColor =
        isDark ? AppTheme.darkTextPrimary : const Color(0xFF27272A);
    return GestureDetector(
      onTap: () => Get.offAllNamed(AppRoutes.home),
      child: SizedBox(
        width: 48,
        height: 32,
        child: Image.asset('assets/images/logo.png', color: logoColor),
      ),
    );
  }

  Widget _buildThemeToggle(ThemeController controller, bool isDark) {
    return GestureDetector(
      onTap: () {
        controller.toggleTheme(); // Ensure this triggers the theme change
        debugPrint('Theme toggled to: ${controller.isDarkMode}'); // Debugging
      },
      child: Icon(
        isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        size: 22,
        color: isDark ? AppTheme.darkTextPrimary : const Color(0xFF27272A),
      ),
    );
  }

  Widget _buildNavItem(
    String title,
    int index,
    String route,
    ThemeController controller,
    bool isDark,
  ) {
    final bool isActive = currentIndex == index;
    final textPrimary =
        isDark ? AppTheme.darkTextPrimary : const Color(0xFF27272A);

    return TextButton(
      onPressed: () => Get.toNamed(route),
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 15,
          fontWeight: isActive ? AppTheme.bold : AppTheme.medium,
          color: isActive ? textPrimary : textPrimary.withOpacity(0.7),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, ThemeController controller) {
    // Get the current theme mode
    final isDark = controller.isDarkMode;
    debugPrint('Opening mobile menu with isDarkMode = $isDark');

    showModalBottomSheet(
      context: context,
      backgroundColor:
          isDark ? const Color(0xFF18181B) : const Color(0xFFF4F4F5),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button and theme toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Close button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color:
                            isDark
                                ? AppTheme.darkTextPrimary
                                : const Color(0xFF27272A),
                      ),
                    ),

                    // Theme toggle
                    GestureDetector(
                      onTap: () {
                        controller.toggleTheme();
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.pop(context);
                        });
                      },
                      child: Icon(
                        Icons.wb_sunny_outlined,
                        size: 22,
                        color:
                            isDark
                                ? AppTheme.darkTextPrimary
                                : const Color(0xFF27272A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),

                // Navigation items
                GestureDetector(
                  onTap: () => _navigateTo(context, AppRoutes.works),
                  child: _buildMobileMenuItem('works', 0, controller, isDark),
                ),
                GestureDetector(
                  onTap: () => _navigateTo(context, AppRoutes.blog),
                  child: _buildMobileMenuItem('blog', 1, controller, isDark),
                ),
                GestureDetector(
                  onTap: () => _navigateTo(context, AppRoutes.bookNotes),
                  child: _buildMobileMenuItem(
                    'book notes',
                    2,
                    controller,
                    isDark,
                  ),
                ),
                GestureDetector(
                  onTap: () => _navigateTo(context, AppRoutes.resources),
                  child: _buildMobileMenuItem(
                    'resources',
                    3,
                    controller,
                    isDark,
                  ),
                ),
                GestureDetector(
                  onTap: () => _navigateTo(context, AppRoutes.about),
                  child: _buildMobileMenuItem('about', 4, controller, isDark),
                ),
                GestureDetector(
                  onTap: () => _navigateTo(context, AppRoutes.now),
                  child: _buildMobileMenuItem('now', 5, controller, isDark),
                ),
              ],
            ),
          ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context); // Close the bottom sheet
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.toNamed(route);
    });
  }

  Widget _buildMobileMenuItem(
    String title,
    int index,
    ThemeController controller,
    bool isDark,
  ) {
    final bool isActive = currentIndex == index;
    final textPrimary =
        isDark ? AppTheme.darkTextPrimary : const Color(0xFF27272A);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 24,
          fontWeight: isActive ? AppTheme.bold : AppTheme.medium,
          color: isActive ? textPrimary : textPrimary.withOpacity(0.7),
        ),
      ),
    );
  }
}

// Custom painter for 'A' (upright triangle) and 'K' (left-pointing triangle)
class AKGeometricLogoPainter extends CustomPainter {
  final Color color;
  AKGeometricLogoPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    // 'A' - Upright triangle (left)
    final aPath = Path();
    aPath.moveTo(size.width * 0.08, size.height * 0.95); // Bottom left
    aPath.lineTo(size.width * 0.20, size.height * 0.05); // Top
    aPath.lineTo(size.width * 0.32, size.height * 0.95); // Bottom right
    aPath.close();
    canvas.drawPath(aPath, paint);

    // 'K' - Left-pointing triangle (right)
    final kPath = Path();
    kPath.moveTo(size.width * 0.44, size.height * 0.18); // Top right
    kPath.lineTo(size.width * 0.44, size.height * 0.82); // Bottom right
    kPath.lineTo(
      size.width * 0.32,
      size.height * 0.5,
    ); // Middle left (points left)
    kPath.close();
    canvas.drawPath(kPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
