import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../config/theme.dart';

class ThemeController extends GetxController {
  static ThemeController get instance => Get.find();
  final _storage = GetStorage();
  final _key = 'isDarkMode';

  // Observable for theme state
  final _isDarkMode = true.obs;

  // Getters
  bool get isDarkMode => _isDarkMode.value;
  ThemeMode get themeMode =>
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  ThemeData get theme =>
      _isDarkMode.value ? AppTheme.darkTheme : AppTheme.lightTheme;

  // Color getters for direct access in widgets
  Color get backgroundColor => AppTheme.backgroundColor(_isDarkMode.value);
  Color get surfaceColor => AppTheme.surfaceColor(_isDarkMode.value);
  Color get textPrimaryColor => AppTheme.textPrimaryColor(_isDarkMode.value);
  Color get textSecondaryColor =>
      AppTheme.textSecondaryColor(_isDarkMode.value);
  Color get textMutedColor => AppTheme.textMutedColor(_isDarkMode.value);
  Color get borderColor => AppTheme.borderColor(_isDarkMode.value);
  Color get footerBackgroundColor =>
      isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF8F8F8);

  @override
  void onInit() {
    super.onInit();
    // Load saved theme
    _loadSavedTheme();
    debugPrint('Theme initialized: isDarkMode = ${_isDarkMode.value}');

    // Set up reaction to theme changes
    ever(_isDarkMode, _updateTheme);
  }

  // Load the saved theme preference
  void _loadSavedTheme() {
    final savedTheme = _storage.read<bool>(_key);
    debugPrint('Saved theme value from storage: $savedTheme');
    if (savedTheme != null) {
      _isDarkMode.value = savedTheme;
    }
  }

  // Update theme when _isDarkMode changes
  void _updateTheme(bool isDark) {
    debugPrint('Updating theme: isDarkMode = $isDark');
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    _storage.write(_key, isDark);
  }

  // Toggle between dark and light mode
  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    update(); // Notify listeners about the change
  }

  // Set specific theme
  void setTheme(bool isDark) {
    debugPrint('Setting theme: isDarkMode = $isDark');
    _isDarkMode.value = isDark;
  }
}
