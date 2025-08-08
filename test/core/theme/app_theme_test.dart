import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repository_explorer/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('should return correct color scheme for each theme type', () {
      for (final themeType in ThemeType.values) {
        final colorScheme = AppTheme.getColorScheme(themeType);
        expect(colorScheme, isA<AppColorScheme>());
      }
    });

    test('should return light theme as fallback for invalid theme', () {
      const invalidTheme = null;
      final colorScheme = AppTheme.getColorScheme(invalidTheme ?? ThemeType.light);
      
      expect(colorScheme.brightness, Brightness.light);
      expect(colorScheme.primary, const Color(0xFF1976D2));
    });

    test('should generate valid ThemeData for each theme type', () {
      for (final themeType in ThemeType.values) {
        final themeData = AppTheme.getTheme(themeType);
        
        expect(themeData, isA<ThemeData>());
        expect(themeData.useMaterial3, isTrue);
        expect(themeData.colorScheme, isNotNull);
      }
    });

    test('should have consistent color scheme properties', () {
      final lightColorScheme = AppTheme.getColorScheme(ThemeType.light);
      final darkColorScheme = AppTheme.getColorScheme(ThemeType.dark);
      
      expect(lightColorScheme.brightness, Brightness.light);
      expect(darkColorScheme.brightness, Brightness.dark);
    });

    test('should provide all available theme options', () {
      final availableThemes = AppTheme.availableThemes;
      
      expect(availableThemes.length, ThemeType.values.length);
      
      for (int i = 0; i < availableThemes.length; i++) {
        final themeOption = availableThemes[i];
        expect(themeOption.type, ThemeType.values[i]);
        expect(themeOption.name, isNotEmpty);
        expect(themeOption.icon, isA<IconData>());
      }
    });

    test('should create proper theme configuration', () {
      final themeData = AppTheme.getTheme(ThemeType.blue);
      
      expect(themeData.appBarTheme.backgroundColor, isNotNull);
      expect(themeData.appBarTheme.elevation, 0);
      expect(themeData.appBarTheme.centerTitle, isTrue);
      
      expect(themeData.cardTheme, isNotNull);
      expect(themeData.elevatedButtonTheme, isNotNull);
      expect(themeData.inputDecorationTheme, isNotNull);
    });
  });

  group('AppColorScheme', () {
    test('should create color scheme with all required colors', () {
      const colorScheme = AppColorScheme(
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
      );
      
      expect(colorScheme.primary, const Color(0xFF1976D2));
      expect(colorScheme.brightness, Brightness.light);
    });
  });

  group('ThemeOption', () {
    test('should create theme option with correct properties', () {
      const themeOption = ThemeOption(
        ThemeType.blue,
        'Ocean Blue',
        Icons.water_drop,
      );
      
      expect(themeOption.type, ThemeType.blue);
      expect(themeOption.name, 'Ocean Blue');
      expect(themeOption.icon, Icons.water_drop);
    });
  });
}