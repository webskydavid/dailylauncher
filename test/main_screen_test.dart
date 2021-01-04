import 'package:dailylauncher/screens/screens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dailylauncher/main.dart';

List mockData = [
  {'id': '111'},
  {'id': '222'},
  {'id': '333'}
];

void main() {
  Widget rootWidget;

  setUpAll(() {
    rootWidget = MaterialApp(
      home: MainScreen(),
    );
  });

  group('MainScreenWidget', () {
    testWidgets('should have "Scaffold" and "MainScreen" widget in the tree',
        (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(MainScreen), findsOneWidget);
    });

    // group('and user drag right', () {
    //   testWidgets('should show prevouse day',
    //       (WidgetTester tester) async {
    //     await tester.pumpWidget(rootWidget);
    //     await tester.drag(find.byKey(Key('')), offset)
    //     expect(find.byType(AppBar), findsOneWidget);
    //     expect(find.text('Today'), findsOneWidget);
    //     expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    //   });
    // });

    group('and is current day', () {
      testWidgets('should show AppBar with title "Today" and calendar button',
          (WidgetTester tester) async {
        await tester.pumpWidget(rootWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Today'), findsOneWidget);
        expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      });

      testWidgets('should show floatingActionButton "Add"',
          (WidgetTester tester) async {
        await tester.pumpWidget(rootWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
      });

      testWidgets('should show list of events', (WidgetTester tester) async {
        await tester.pumpWidget(rootWidget);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byKey(Keys.eventKey), findsNWidgets(3));
        mockData.asMap().forEach((key, value) {
          expect(find.text(key.toString()), findsOneWidget);
        });
      });

      testWidgets('should show bottom navigation', (WidgetTester tester) async {
        await tester.pumpWidget(rootWidget);
        expect(find.byIcon(Icons.event), findsOneWidget);
        expect(find.byIcon(Icons.shopping_basket), findsOneWidget);
      });

      group('and user clicks on "shopping_basket" button', () {
        testWidgets('should show ShoppingListScreen',
            (WidgetTester tester) async {
          await tester.pumpWidget(rootWidget);
          await tester.tap(find.byIcon(Icons.shopping_basket));
          await tester.pumpAndSettle();
          expect(find.byType(MainScreen), findsNothing);
          expect(find.byType(ShoppingListScreen), findsOneWidget);
        });
      });
    });
  });
}
