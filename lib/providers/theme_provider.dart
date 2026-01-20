import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_theme.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(AppTheme.lightTheme) {
    _loadTheme();
  }

  // Load theme from shared preferences
  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDark') ?? false;
      state = isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
    } catch (e) {
      // Fallback to light theme if there's an error
      state = AppTheme.lightTheme;
    }
  }

  // Toggle between light and dark theme
  Future<void> toggleTheme() async {
    state = state.brightness == Brightness.dark 
        ? AppTheme.lightTheme 
        : AppTheme.darkTheme;
    
    // Save theme preference
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDark', state.brightness == Brightness.dark);
    } catch (e) {
      // Ignore error if saving fails
    }
  }
}
