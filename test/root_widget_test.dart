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
    testWidgets('should have specific number of icons',
        (WidgetTester tester) async {
      await _buildWidget(tester);
      Finder bottomNavigationBar = find.byType(BottomNavigationBar);
      Finder icon = find.byType(Icon);
      Finder icons = find.descendant(of: bottomNavigationBar, matching: icon);
      int count = tester.widgetList(icons).length;
      expect(count, greaterThanOrEqualTo(2));
    });

    testWidgets('should show MainScreen', (WidgetTester tester) async {
      await _buildWidget(tester);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(EventsScreen), findsOneWidget);
    });

    testWidgets('should show AppBar with title "Today"',
        (WidgetTester tester) async {
      await _buildWidget(tester);
      expect(
          find.descendant(
              of: find.byType(AppBar), matching: find.text('Today')),
          findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('should show floatingActionButton "Add"',
        (WidgetTester tester) async {
      await _buildWidget(tester);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should show bottom navigation with "MainScreen" selected',
        (WidgetTester tester) async {
      await _buildWidget(tester);
      Finder finderBar = find.byType(BottomNavigationBar);
      expect(finderBar, findsOneWidget);
      BottomNavigationBar bar = tester.widget<BottomNavigationBar>(
          finderBar); // TIP: Get widget to access params
      expect(bar.currentIndex, 0);
    });

    group('and user taps one of the icons on navigation bar', () {
      testWidgets(
          'should show bottom navigation with "GroceryListScreen" selected',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        await tester.tap(find.byIcon(Screens.list[1].icon.icon));
        await tester.pumpAndSettle();

        Finder bar = find.byType(AppBar);
        Finder title = find.text(Screens.list[1].title);
        Finder menuIcon = find.byIcon(Icons.menu);

        // TIP: Find widget inside another widget
        expect(find.descendant(of: bar, matching: title), findsOneWidget);
        expect(find.descendant(of: bar, matching: menuIcon), findsOneWidget);

        expect(find.byType(GroceryScreen), findsOneWidget);
      });

      testWidgets('should show bottom navigation with "EventsScreen" selected',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        await tester.tap(find.byIcon(Screens.list[0].icon.icon));
        await tester.pumpAndSettle();

        Finder bar = find.byType(AppBar);
        Finder title = find.text(Screens.list[0].title);
        Finder menuIcon = find.byIcon(Icons.calendar_today);

        // TIP: Find widget childs inside another widget
        expect(find.descendant(of: bar, matching: title), findsOneWidget);
        expect(find.descendant(of: bar, matching: menuIcon), findsOneWidget);
        expect(find.byType(EventsScreen), findsOneWidget);
      });
    });

    group('and user taps on floating action button', () {
      testWidgets('should show screen for adding "Grocery products"',
          (WidgetTester tester) async {
        await _buildWidget(tester);
        expect(find.byType(ListView), findsOneWidget);

        await tester.tap(find.byIcon(Icons.shopping_cart));
        await tester.pumpAndSettle();
        expect(find.byType(GroceryScreen), findsOneWidget);

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();
        expect(find.byType(AddGroceryProductScreen), findsOneWidget);
      });
    });
  });
}
