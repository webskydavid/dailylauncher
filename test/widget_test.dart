import 'package:dailylauncher/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dailylauncher/main.dart';

void main() {
  Widget rootWidget;

  setUpAll(() {
    rootWidget = RootWidget();
  });

  group('RootWidget', () {
    testWidgets('should show mainscreen', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });

  group('MainScreen for current day', () {
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
      expect(find.byKey(Keys.event_key), findsNWidgets(3));
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });
  });
}
