import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/owner_model.dart';
import '../../models/repository_model.dart';
import '../../models/search_result_model.dart';

class DatabaseHelper {
  static const String searchResultBoxName = 'searchResults';
  
  static Future<void> init() async {
    await Hive.initFlutter();
    
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(OwnerModelAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(RepositoryModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(SearchResultModelAdapter());
    }
  }

  static Future<Box<SearchResultModel>> getSearchResultBox() async {
    try {
      return await Hive.openBox<SearchResultModel>(searchResultBoxName);
    } catch (e) {
      debugPrint('Warning: Hive box lock issue detected, attempting cleanup...');
      try {
        await Hive.close();
        await Future.delayed(const Duration(milliseconds: 500));
        return await Hive.openBox<SearchResultModel>(searchResultBoxName);
      } catch (e2) {
        debugPrint('Warning: Could not open Hive box, using in-memory storage: $e2');
        return await Hive.openBox<SearchResultModel>('temp_${DateTime.now().millisecondsSinceEpoch}');
      }
    }
  }

  static Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}