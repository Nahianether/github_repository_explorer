import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:github_repository_explorer/core/theme/theme_storage.dart';
import 'package:github_repository_explorer/core/theme/app_theme.dart';

void main() {
  group('ThemeStorage', () {
    test('should save and retrieve theme', () async {
      Hive.init('./test/temp_hive_${DateTime.now().millisecondsSinceEpoch}');
      
      await ThemeStorage.init();
      
      await ThemeStorage.saveTheme(ThemeType.dark);
      final retrievedTheme = ThemeStorage.getTheme();
      
      expect(retrievedTheme, ThemeType.dark);
      
      await Hive.close();
      await Hive.deleteFromDisk();
    });

    test('should return light theme as default when no box exists', () async {
      // This test verifies default behavior without opening a box
      final defaultTheme = ThemeStorage.getTheme();
      
      expect(defaultTheme, ThemeType.light);
    });

    test('should handle invalid theme name gracefully', () async {
      Hive.init('./test/temp_hive_${DateTime.now().millisecondsSinceEpoch}');
      
      await ThemeStorage.init();
      final box = Hive.box<String>('theme_storage');
      
      await box.put('selected_theme', 'invalid_theme');
      
      final theme = ThemeStorage.getTheme();
      
      expect(theme, ThemeType.light);
      
      await Hive.close();
      await Hive.deleteFromDisk();
    });

    test('should clear theme successfully', () async {
      Hive.init('./test/temp_hive_${DateTime.now().millisecondsSinceEpoch}');
      
      await ThemeStorage.init();
      
      await ThemeStorage.saveTheme(ThemeType.blue);
      expect(ThemeStorage.getTheme(), ThemeType.blue);
      
      await ThemeStorage.clearTheme();
      expect(ThemeStorage.getTheme(), ThemeType.light);
      
      await Hive.close();
      await Hive.deleteFromDisk();
    });

    test('should handle multiple theme changes', () async {
      Hive.init('./test/temp_hive_${DateTime.now().millisecondsSinceEpoch}');
      
      await ThemeStorage.init();
      
      final themes = [
        ThemeType.blue,
        ThemeType.green,
        ThemeType.purple,
        ThemeType.orange,
      ];
      
      for (final theme in themes) {
        await ThemeStorage.saveTheme(theme);
        expect(ThemeStorage.getTheme(), theme);
      }
      
      await Hive.close();
      await Hive.deleteFromDisk();
    });
  });
}