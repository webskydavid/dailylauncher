import 'dart:developer';

import 'package:dailylauncher/screens/screens.dart';
import 'package:dailylauncher/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget rootWidget;

  setUpAll(() {
    rootWidget = MaterialApp(
      home: RootWidget(),
    );
  });

  group('RootWidget', () {
    testWidgets('should show MainScreen', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('should show AppBar with title "Today"',
        (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget);
      expect(
          find.descendant(
              of: find.byType(AppBar), matching: find.text('Today')),
          findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('should show floatingActionButton "Add"',
        (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should show bottom navigation with "MainScreen" selected',
        (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget);
      Finder finderBar = find.byType(BottomNavigationBar);
      expect(finderBar, findsOneWidget);
      BottomNavigationBar bar = tester.widget<BottomNavigationBar>(
          finderBar); // TIP: Get widget to access params
      expect(bar.currentIndex, 0);
    });

    group('and user taps one of the icons on navigation bar', () {
      testWidgets('should show bottom navigation with "GroceryScreen" selected',
          (WidgetTester tester) async {
        await tester.pumpWidget(rootWidget);
        await tester.tap(find.byIcon(screens[1].icon.icon));
        await tester.pumpAndSettle();

        Finder bar = find.byType(AppBar);
        Finder title = find.text(screens[1].title);
        Finder menuIcon = find.byIcon(Icons.menu);

        // TIP: Find widget inside another widget
        expect(find.descendant(of: bar, matching: title), findsOneWidget);
        expect(find.descendant(of: bar, matching: menuIcon), findsOneWidget);

        expect(find.byType(GroceryScreen), findsOneWidget);
      });

      testWidgets('should show bottom navigation with "Events" selected',
          (WidgetTester tester) async {
        await tester.pumpWidget(rootWidget);
        await tester.tap(find.byIcon(screens[0].icon.icon));
        await tester.pumpAndSettle();

        Finder bar = find.byType(AppBar);
        Finder title = find.text(screens[0].title);
        Finder menuIcon = find.byIcon(Icons.calendar_today);

        // TIP: Find widget childs inside another widget
        expect(find.descendant(of: bar, matching: title), findsOneWidget);
        expect(find.descendant(of: bar, matching: menuIcon), findsOneWidget);
        expect(find.byType(MainScreen), findsOneWidget);
      });
    });

    group('and user taps on floating action button', () {
      testWidgets('should show add form for "Grocery"',
          (WidgetTester tester) async {
        await tester.pumpWidget(rootWidget);

        await tester.tap(find.byIcon(screens[1].icon.icon));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(screens[1].appBarIcon.icon));
        await tester.pumpAndSettle(Duration(milliseconds: 2000));

        expect(find.text('Add grocery'), findsOneWidget);
        expect(find.byType(AddGroceryScreen), findsOneWidget);
      });
    });
  });
}
