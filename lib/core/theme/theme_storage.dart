import 'package:hive/hive.dart';
import 'app_theme.dart';

class ThemeStorage {
  static const String _boxName = 'theme_storage';
  static const String _themeKey = 'selected_theme';
  
  static Box<String>? _box;

  static Future<void> init() async {
    _box = await Hive.openBox<String>(_boxName);
  }

  static Future<void> saveTheme(ThemeType themeType) async {
    if (_box == null) await init();
    await _box!.put(_themeKey, themeType.name);
  }

  static ThemeType getTheme() {
    if (_box == null || !_box!.isOpen) return ThemeType.light;
    
    try {
      final themeName = _box!.get(_themeKey);
      if (themeName == null) return ThemeType.light;
      
      return ThemeType.values.firstWhere(
        (theme) => theme.name == themeName,
        orElse: () => ThemeType.light,
      );
    } catch (e) {
      return ThemeType.light;
    }
  }

  static Future<void> clearTheme() async {
    if (_box == null) await init();
    await _box!.delete(_themeKey);
  }
}