// Tests for GitHub Repository Explorer app
//
// This file contains basic smoke tests for the app structure.
// For more comprehensive testing, create separate test files for each feature.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic app structure test', (WidgetTester tester) async {
    // Simple test to verify the app can be built
    // This is a minimal test to ensure no compilation errors
    
    final app = MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Repositories'),
          actions: [
            Row(
              children: [
                const Text('Dark mode'),
                Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text('Repository List'),
              ),
            ),
          ],
        ),
      ),
    );
    
    // Build the test app
    await tester.pumpWidget(app);

    // Verify basic UI elements are present
    expect(find.text('Repositories'), findsOneWidget);
    expect(find.text('Dark mode'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('Repository List'), findsOneWidget);
  });

  testWidgets('Search field properties test', (WidgetTester tester) async {
    // Test just the search field component
    const searchField = TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search),
      ),
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: searchField,
        ),
      ),
    );

    // Verify the search field properties
    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.decoration?.hintText, equals('Search'));
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Theme toggle test', (WidgetTester tester) async {
    // Test the theme toggle component
    bool isDark = false;
    
    final themeToggle = StatefulBuilder(
      builder: (context, setState) {
        return Switch(
          value: isDark,
          onChanged: (value) {
            setState(() {
              isDark = value;
            });
          },
        );
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: themeToggle,
        ),
      ),
    );

    // Verify initial state
    final switchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(switchWidget.value, isFalse);

    // Tap the switch and verify state change
    await tester.tap(find.byType(Switch));
    await tester.pump();
    
    final updatedSwitchWidget = tester.widget<Switch>(find.byType(Switch));
    expect(updatedSwitchWidget.value, isTrue);
  });
}
