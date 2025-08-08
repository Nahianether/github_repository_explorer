import 'package:flutter/material.dart';

enum ThemeType {
  light,
  dark,
  blue,
  green,
  purple,
  orange,
  red,
  teal,
  pink,
  indigo,
}

class AppTheme {
  static const String _fontFamily = 'System';

  static final Map<ThemeType, AppColorScheme> _colorSchemes = {
    ThemeType.light: const AppColorScheme(
      primary: Color(0xFF1976D2),
      primaryContainer: Color(0XFFE3F2FD),
      secondary: Color(0xFF424242),
      secondaryContainer: Color(0xFFF5F5F5),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFF3F3F3),
      background: Color(0xFFFFFBFE),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onPrimaryContainer: Color(0xFF0D47A1),
      onSecondary: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFF1A1A1A),
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF424242),
      onBackground: Color(0xFF1A1A1A),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFFBDBDBD),
      shadow: Color(0xFF000000),
      brightness: Brightness.light,
    ),
    ThemeType.dark: const AppColorScheme(
      primary: Color(0xFF90CAF9),
      primaryContainer: Color(0xFF0D47A1),
      secondary: Color(0xFFBDBDBD),
      secondaryContainer: Color(0xFF424242),
      surface: Color(0xFF121212),
      surfaceVariant: Color(0xFF2C2C2C),
      background: Color(0xFF121212),
      error: Color(0xFFCF6679),
      onPrimary: Color(0xFF0D47A1),
      onPrimaryContainer: Color(0xFFE3F2FD),
      onSecondary: Color(0xFF000000),
      onSecondaryContainer: Color(0xFFE0E0E0),
      onSurface: Color(0xFFE0E0E0),
      onSurfaceVariant: Color(0xFFBDBDBD),
      onBackground: Color(0xFFE0E0E0),
      onError: Color(0xFF000000),
      outline: Color(0xFF757575),
      shadow: Color(0xFF000000),
      brightness: Brightness.dark,
    ),
    ThemeType.blue: const AppColorScheme(
      primary: Color(0xFF2196F3),
      primaryContainer: Color(0xFFE3F2FD),
      secondary: Color(0xFF03DAC6),
      secondaryContainer: Color(0xFFE0F7FA),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFF1F8FF),
      background: Color(0xFFFFFBFE),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onPrimaryContainer: Color(0xFF0D47A1),
      onSecondary: Color(0xFF000000),
      onSecondaryContainer: Color(0xFF00695C),
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF424242),
      onBackground: Color(0xFF1A1A1A),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFFBDBDBD),
      shadow: Color(0xFF000000),
      brightness: Brightness.light,
    ),
    ThemeType.green: const AppColorScheme(
      primary: Color(0xFF4CAF50),
      primaryContainer: Color(0xFFE8F5E8),
      secondary: Color(0xFF8BC34A),
      secondaryContainer: Color(0xFFF1F8E9),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFF8FFF8),
      background: Color(0xFFFFFBFE),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onPrimaryContainer: Color(0xFF1B5E20),
      onSecondary: Color(0xFF000000),
      onSecondaryContainer: Color(0xFF33691E),
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF424242),
      onBackground: Color(0xFF1A1A1A),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFFBDBDBD),
      shadow: Color(0xFF000000),
      brightness: Brightness.light,
    ),
    ThemeType.purple: const AppColorScheme(
      primary: Color(0xFF9C27B0),
      primaryContainer: Color(0xFFF3E5F5),
      secondary: Color(0xFF673AB7),
      secondaryContainer: Color(0xFFEDE7F6),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFFAF8FF),
      background: Color(0xFFFFFBFE),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onPrimaryContainer: Color(0xFF4A148C),
      onSecondary: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFF311B92),
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF424242),
      onBackground: Color(0xFF1A1A1A),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFFBDBDBD),
      shadow: Color(0xFF000000),
      brightness: Brightness.light,
    ),
    ThemeType.orange: const AppColorScheme(
      primary: Color(0xFFFF9800),
      primaryContainer: Color(0xFFFFF3E0),
      secondary: Color(0xFFFF5722),
      secondaryContainer: Color(0xFFFBE9E7),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFFFFAF5),
      background: Color(0xFFFFFBFE),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onPrimaryContainer: Color(0xFFE65100),
      onSecondary: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFFBF360C),
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF424242),
      onBackground: Color(0xFF1A1A1A),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFFBDBDBD),
      shadow: Color(0xFF000000),
      brightness: Brightness.light,
    ),
    ThemeType.red: const AppColorScheme(
      primary: Color(0xFFF44336),
      primaryContainer: Color(0xFFFFEBEE),
      secondary: Color(0xFFE91E63),
      secondaryContainer: Color(0xFFFCE4EC),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFFFF8F8),
      background: Color(0xFFFFFBFE),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onPrimaryContainer: Color(0xFFB71C1C),
      onSecondary: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFF880E4F),
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF424242),
      onBackground: Color(0xFF1A1A1A),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFFBDBDBD),
      shadow: Color(0xFF000000),
      brightness: Brightness.light,
    ),
    ThemeType.teal: const AppColorScheme(
      primary: Color(0xFF009688),
      primaryContainer: Color(0xFFE0F2F1),
      secondary: Color(0xFF26A69A),
      secondaryContainer: Color(0xFFE0F7FA),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFF0FFF4),
      background: Color(0xFFFFFBFE),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onPrimaryContainer: Color(0xFF004D40),
      onSecondary: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFF006064),
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF424242),
      onBackground: Color(0xFF1A1A1A),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFFBDBDBD),
      shadow: Color(0xFF000000),
      brightness: Brightness.light,
    ),
    ThemeType.pink: const AppColorScheme(
      primary: Color(0xFFE91E63),
      primaryContainer: Color(0xFFFCE4EC),
      secondary: Color(0xFFEC407A),
      secondaryContainer: Color(0xFFF8BBD9),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFFFF0F5),
      background: Color(0xFFFFFBFE),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onPrimaryContainer: Color(0xFF880E4F),
      onSecondary: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFFAD1457),
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF424242),
      onBackground: Color(0xFF1A1A1A),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFFBDBDBD),
      shadow: Color(0xFF000000),
      brightness: Brightness.light,
    ),
    ThemeType.indigo: const AppColorScheme(
      primary: Color(0xFF3F51B5),
      primaryContainer: Color(0xFFE8EAF6),
      secondary: Color(0xFF5C6BC0),
      secondaryContainer: Color(0xFFC5CAE9),
      surface: Color(0xFFFFFBFE),
      surfaceVariant: Color(0xFFF5F5FF),
      background: Color(0xFFFFFBFE),
      error: Color(0xFFD32F2F),
      onPrimary: Color(0xFFFFFFFF),
      onPrimaryContainer: Color(0xFF1A237E),
      onSecondary: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFF283593),
      onSurface: Color(0xFF1A1A1A),
      onSurfaceVariant: Color(0xFF424242),
      onBackground: Color(0xFF1A1A1A),
      onError: Color(0xFFFFFFFF),
      outline: Color(0xFFBDBDBD),
      shadow: Color(0xFF000000),
      brightness: Brightness.light,
    ),
  };

  static AppColorScheme getColorScheme(ThemeType themeType) {
    return _colorSchemes[themeType] ?? _colorSchemes[ThemeType.light]!;
  }

  static ThemeData getTheme(ThemeType themeType) {
    final colorScheme = getColorScheme(themeType);
    
    return ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      brightness: colorScheme.brightness,
      colorScheme: ColorScheme(
        brightness: colorScheme.brightness,
        primary: colorScheme.primary,
        onPrimary: colorScheme.onPrimary,
        primaryContainer: colorScheme.primaryContainer,
        onPrimaryContainer: colorScheme.onPrimaryContainer,
        secondary: colorScheme.secondary,
        onSecondary: colorScheme.onSecondary,
        secondaryContainer: colorScheme.secondaryContainer,
        onSecondaryContainer: colorScheme.onSecondaryContainer,
        tertiary: colorScheme.secondary,
        onTertiary: colorScheme.onSecondary,
        tertiaryContainer: colorScheme.secondaryContainer,
        onTertiaryContainer: colorScheme.onSecondaryContainer,
        error: colorScheme.error,
        onError: colorScheme.onError,
        errorContainer: colorScheme.error,
        onErrorContainer: colorScheme.onError,
        surface: colorScheme.surface,
        onSurface: colorScheme.onSurface,
        surfaceContainerHighest: colorScheme.surfaceVariant,
        onSurfaceVariant: colorScheme.onSurfaceVariant,
        outline: colorScheme.outline,
        outlineVariant: colorScheme.outline,
        shadow: colorScheme.shadow,
        scrim: colorScheme.shadow,
        inverseSurface: colorScheme.onSurface,
        onInverseSurface: colorScheme.surface,
        inversePrimary: colorScheme.onPrimary,
        surfaceTint: colorScheme.primary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: _fontFamily,
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceVariant,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceVariant,
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        selectedColor: colorScheme.primaryContainer,
        checkmarkColor: colorScheme.onPrimaryContainer,
      ),
    );
  }

  static List<ThemeOption> get availableThemes => [
    const ThemeOption(ThemeType.light, 'Light', Icons.light_mode),
    const ThemeOption(ThemeType.dark, 'Dark', Icons.dark_mode),
    const ThemeOption(ThemeType.blue, 'Ocean Blue', Icons.water_drop),
    const ThemeOption(ThemeType.green, 'Forest Green', Icons.eco),
    const ThemeOption(ThemeType.purple, 'Royal Purple', Icons.auto_awesome),
    const ThemeOption(ThemeType.orange, 'Sunset Orange', Icons.wb_sunny),
    const ThemeOption(ThemeType.red, 'Cherry Red', Icons.favorite),
    const ThemeOption(ThemeType.teal, 'Mint Teal', Icons.spa),
    const ThemeOption(ThemeType.pink, 'Sakura Pink', Icons.local_florist),
    const ThemeOption(ThemeType.indigo, 'Deep Indigo', Icons.nightlife),
  ];
}

class AppColorScheme {
  final Color primary;
  final Color primaryContainer;
  final Color secondary;
  final Color secondaryContainer;
  final Color surface;
  final Color surfaceVariant;
  final Color background;
  final Color error;
  final Color onPrimary;
  final Color onPrimaryContainer;
  final Color onSecondary;
  final Color onSecondaryContainer;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color onBackground;
  final Color onError;
  final Color outline;
  final Color shadow;
  final Brightness brightness;

  const AppColorScheme({
    required this.primary,
    required this.primaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.surface,
    required this.surfaceVariant,
    required this.background,
    required this.error,
    required this.onPrimary,
    required this.onPrimaryContainer,
    required this.onSecondary,
    required this.onSecondaryContainer,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.onBackground,
    required this.onError,
    required this.outline,
    required this.shadow,
    required this.brightness,
  });
}

class ThemeOption {
  final ThemeType type;
  final String name;
  final IconData icon;

  const ThemeOption(this.type, this.name, this.icon);
}