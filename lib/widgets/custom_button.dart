import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/config/theme.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

Widget buildButton(
  BuildContext context, {
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
  required bool isPrimary,
  required bool isDark,
}) {
  final themeController = Get.find<ThemeController>();

  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: FaIcon(
      icon,
      size: 16,
      color:
          isPrimary
              ? (isDark ? Colors.black : Colors.white)
              : themeController.textPrimaryColor,
    ),
    label: Text(
      label,
      style: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontSize: 14,
        color:
            isPrimary
                ? (isDark ? Colors.black : Colors.white)
                : themeController.textPrimaryColor,
      ),
    ),
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      backgroundColor: WidgetStateProperty.all(
        isPrimary ? (isDark ? Colors.white : Colors.black) : Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.all(
        isPrimary
            ? (isDark ? Colors.black : Colors.white)
            : themeController.textPrimaryColor,
      ),
      elevation: WidgetStateProperty.all(isPrimary ? 2 : 0),
      shadowColor: WidgetStateProperty.all(
        isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      side: WidgetStateProperty.all(
        isPrimary
            ? BorderSide.none
            : BorderSide(color: themeController.borderColor, width: 1),
      ),
      // Enable proper splash effects
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed)) {
          return isPrimary
              ? (isDark
                  ? Colors.black.withOpacity(0.1)
                  : Colors.white.withOpacity(0.1))
              : themeController.textPrimaryColor.withOpacity(0.1);
        }
        if (states.contains(WidgetState.hovered)) {
          return isPrimary
              ? (isDark
                  ? Colors.black.withOpacity(0.05)
                  : Colors.white.withOpacity(0.05))
              : themeController.textPrimaryColor.withOpacity(0.05);
        }
        return null;
      }),
    ),
  );
}
