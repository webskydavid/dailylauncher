import 'package:dailylauncher/main.dart';
import 'package:dailylauncher/screens/screens.dart';
import 'package:dailylauncher/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> _buildWidget(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: RootWidget(Screens.list),
    ));
  }

  group('RootWidget', () {
    group('when initialize', () {
      testWidgets('should show AppBar with title "Today"',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        expect(
            find.descendant(
                of: find.byType(AppBar), matching: find.text('Today')),
            findsOneWidget);
        expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      });

      testWidgets('should show MainScreen', (WidgetTester tester) async {
        await _buildWidget(tester);
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(EventsScreen), findsOneWidget);
      });

      testWidgets('should have first icons selected on BottomNavigationBar',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        Finder finderBar = find.byType(BottomNavigationBar);
        expect(finderBar, findsOneWidget);
        BottomNavigationBar bar = tester.widget<BottomNavigationBar>(
            finderBar); // TIP: Get widget to access params
        expect(bar.currentIndex, 0);
      });

      testWidgets('should have more then 2 icons on BottomNavigationBar',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        Finder bottomNavigationBar = find.byType(BottomNavigationBar);
        Finder icon = find.byType(Icon);
        Finder icons = find.descendant(of: bottomNavigationBar, matching: icon);
        int count = tester.widgetList(icons).length;
        expect(count, greaterThanOrEqualTo(2));
      });
    });

    group('when EventsScreen', () {
      testWidgets('should show 4 items on the list',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        expect(find.byType(ListView), findsOneWidget);
        expect(
            find.descendant(
                of: find.byType(ListView), matching: find.byType(Text)),
            findsNWidgets(4));
      });
      testWidgets('should show floatingActionButton "Add"',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        expect(find.byIcon(Icons.add), findsOneWidget);
      });
    });

    group('when show ShoppingList', () {
      Future<void> _goToShoppingListScreen(WidgetTester tester) async {
        Finder bottomNavigationIcon = find.byIcon(Screens.list[1].icon.icon);
        await tester.tap(bottomNavigationIcon);
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        await tester.pumpAndSettle();
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(ShoppingListScreen), findsOneWidget);
      }

      testWidgets('should show 0 items on the list',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        await _goToShoppingListScreen(tester);

        expect(find.byType(ListView), findsOneWidget);
        expect(
            find.descendant(
                of: find.byType(ListView), matching: find.byType(Text)),
            findsNWidgets(0));
      });

      testWidgets('should show floatingActionButton "Add"',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        await _goToShoppingListScreen(tester);

        expect(find.byIcon(Icons.add), findsOneWidget);
      });

      group('and user taps on FAB "add"', () {
        Future<void> _goToAddProductScreen(WidgetTester tester) async {
          await tester.tap(find.byIcon(Icons.add));
          await tester.pumpAndSettle();
          expect(find.byType(AddProductScreen), findsOneWidget);
        }

        testWidgets('should show "AddProductScreen"',
            (WidgetTester tester) async {
          await _buildWidget(tester);
          await _goToShoppingListScreen(tester);
          await _goToAddProductScreen(tester);
        });

        group('and user save form', () {
          testWidgets('should show 1 item on the list',
              (WidgetTester tester) async {
            await _buildWidget(tester);
            await _goToShoppingListScreen(tester);
            await _goToAddProductScreen(tester);

            final Finder name = find.widgetWithText(TextField, 'Name');
            final Finder price = find.widgetWithText(TextField, 'Price');
            final Finder amount = find.widgetWithText(TextField, 'Amount');
            final Finder save = find.widgetWithText(ElevatedButton, 'Save');

            await tester.enterText(name, 'Eggs');
            await tester.enterText(price, '30.0');
            await tester.enterText(amount, '2');

            await tester.tap(save);
            await tester.pumpAndSettle();

            final Finder list = find.byType(ListView);
            final Finder productItem = find.byType(Text);

            expect(find.text('Product added'), findsOneWidget);
            expect(find.byType(ShoppingListScreen), findsOneWidget);
            expect(find.descendant(of: list, matching: productItem),
                findsNWidgets(1));
          });
        });

        group('and user save invalid form', () {
          testWidgets('should not save form and should show errors',
              (WidgetTester tester) async {
            await _buildWidget(tester);
            await _goToShoppingListScreen(tester);
            await _goToAddProductScreen(tester);

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
      });
    });
  });
}
