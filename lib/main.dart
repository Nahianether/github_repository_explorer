import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'injection/injection_container.dart' as di;
import 'core/theme/theme_provider.dart';
import 'core/theme/theme_storage.dart';
import 'features/repository_search/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await ThemeStorage.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeDataProvider);

    return MaterialApp(
      title: 'GitHub Repository Explorer',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const HomePage(),
    );
  }
}
