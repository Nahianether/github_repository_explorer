import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_theme.dart';
import 'theme_storage.dart';

class ThemeNotifier extends StateNotifier<ThemeType> {
  ThemeNotifier() : super(ThemeType.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = ThemeStorage.getTheme();
    state = savedTheme;
  }

  Future<void> setTheme(ThemeType themeType) async {
    state = themeType;
    await ThemeStorage.saveTheme(themeType);
  }

  ThemeData get themeData => AppTheme.getTheme(state);
  
  AppColorScheme get colorScheme => AppTheme.getColorScheme(state);
  
  bool get isDark => AppTheme.getColorScheme(state).brightness == Brightness.dark;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeType>(
  (ref) => ThemeNotifier(),
);

final themeDataProvider = Provider<ThemeData>((ref) {
  final themeType = ref.watch(themeProvider);
  return AppTheme.getTheme(themeType);
});

final colorSchemeProvider = Provider<AppColorScheme>((ref) {
  final themeType = ref.watch(themeProvider);
  return AppTheme.getColorScheme(themeType);
});

final isDarkThemeProvider = Provider<bool>((ref) {
  final colorScheme = ref.watch(colorSchemeProvider);
  return colorScheme.brightness == Brightness.dark;
});