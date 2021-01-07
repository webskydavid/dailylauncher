import 'package:dailylauncher/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget rootWidget;

  setUpAll(() {
    rootWidget = MaterialApp(
      home: GroceryScreen(),
    );
  });

  group('GroceryListScreen', () {
    testWidgets('should show ShoppingListScreen', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget);
    });
  });
}
