import 'package:dailylauncher/screens/screens.dart';
import 'package:dailylauncher/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

List bottomNavigationData = [
  {'title': 'Today', 'icon': Icons.event},
  {'title': 'Grocery', 'icon': Icons.shopping_cart},
];

void main() {
  Widget rootWidget;

  setUpAll(() {
    rootWidget = RootWidget();
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
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
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
      BottomNavigationBar bar = tester.widget<BottomNavigationBar>(finderBar);
      expect(bar.currentIndex, 0);
    });

    group('and user taps one of the icons on navigation bar', () {
      testWidgets('should show bottom navigation with "GroceryScreen" selected',
          (WidgetTester tester) async {
        await tester.pumpWidget(rootWidget);
        await tester.tap(find.byIcon(bottomNavigationData[1]['icon']));
        await tester.pumpAndSettle();

        expect(find.byType(GroceryScreen), findsOneWidget);
      });
    });
  });
}
