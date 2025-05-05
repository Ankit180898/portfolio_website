import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_website/config/theme.dart';

Widget buildButton(
  BuildContext context, {
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
  required bool isPrimary,
  required bool isDark,
}) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    icon: FaIcon(
      icon,
      size: 16,
      color:
          isPrimary
              ? (isDark ? Colors.black : Colors.white)
              : (isDark ? Colors.white : Colors.black),
    ),
    label: Text(
      label,
      style: TextStyle(
        fontFamily: AppTheme.fontFamily,
        fontSize: 14,
        color:
            isPrimary
                ? (isDark ? Colors.black : Colors.white)
                : (isDark ? Colors.white : Colors.black),
      ),
    ),
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor:
          isPrimary
              ? (isDark ? Colors.white : Colors.black)
              : Colors.transparent,
      // foregroundColor:
      //     isPrimary
      //         ? (isDark ? Colors.black : Colors.white)
      //         : (isDark ? Colors.white : Colors.black),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      side:
          isPrimary
              ? BorderSide.none
              : BorderSide(
                color: isDark ? Colors.white70 : Colors.black54,
                width: 1,
              ),
    ),
  );
}
