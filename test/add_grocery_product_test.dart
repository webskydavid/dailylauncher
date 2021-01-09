import 'package:dailylauncher/models/models.dart';
import 'package:dailylauncher/screens/screens.dart';
import 'package:dailylauncher/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

List<ScreenModel> screens = [
  ScreenModel(
    'AddGroceryProductScreen',
    Icon(Icons.ac_unit),
    Icon(Icons.ac_unit),
    AddGroceryProductScreen(),
    GroceryScreen(),
  ),
  ScreenModel(
    'test',
    Icon(Icons.ac_unit),
    Icon(Icons.ac_unit),
    Text(''),
    Text(''),
  )
];
void main() {
  Future<void> _buildWidget(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RootWidget(screens),
    ));

    // await expectLater(
    //   find.byType(GroceryScreen),
    //   matchesGoldenFile('./init_grocery_screen.png'),
    // );

    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
  }

  group('GroceryScreen list of items', () {
    testWidgets('should show 2 items on the list', (WidgetTester tester) async {
      await _buildWidget(tester);
      expect(find.widgetWithText(AppBar, 'Add product'), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Price'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });
  });

  group('AddGroceryProduct', () {
    testWidgets('should show form inputs', (WidgetTester tester) async {
      await _buildWidget(tester);
      expect(find.widgetWithText(AppBar, 'Add product'), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Price'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('should fill form and save ', (WidgetTester tester) async {
      await _buildWidget(tester);
      final Finder name = find.widgetWithText(TextField, 'Name');
      final Finder price = find.widgetWithText(TextField, 'Price');
      final Finder amount = find.widgetWithText(TextField, 'Amount');
      final Finder save = find.widgetWithText(ElevatedButton, 'Save');

      await tester.enterText(name, 'Eggs');
      await tester.enterText(price, '30.0');
      await tester.enterText(amount, '2');

      await tester.tap(save);
      await tester.pumpAndSettle();

      expect(find.text('Product added'), findsOneWidget);
      expect(find.byType(GroceryScreen), findsOneWidget);
    });

    testWidgets('should not save form and show errors',
        (WidgetTester tester) async {
      await _buildWidget(tester);
      final Finder name = find.widgetWithText(TextField, 'Name');
      final Finder price = find.widgetWithText(TextField, 'Price');
      final Finder amount = find.widgetWithText(TextField, 'Amount');
      final Finder save = find.widgetWithText(ElevatedButton, 'Save');

      await tester.enterText(name, '');
      await tester.enterText(price, '');
      await tester.enterText(amount, '');

      await tester.tap(save);
      await tester.pump();

      expect(find.text('Name is required'), findsOneWidget);
      expect(find.text('Price is required'), findsOneWidget);
      expect(find.text('Amount is required'), findsOneWidget);
      expect(find.text('Product added'), findsNothing);
    });
  });
}
