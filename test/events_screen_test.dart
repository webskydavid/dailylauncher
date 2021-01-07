import 'package:dailylauncher/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

List mockData = [
  {'id': '111'},
  {'id': '222'},
  {'id': '333'}
];

void main() {
  Widget rootWidget;

  setUpAll(() {
    rootWidget = MaterialApp(
      home: EventsScreen(),
    );
  });

  group('EventsScreenWidget', () {
    testWidgets('should have "MainScreen" widget in the tree',
        (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget);
      expect(find.byType(EventsScreen), findsOneWidget);
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
      testWidgets('should show list of events', (WidgetTester tester) async {
        await tester.pumpWidget(rootWidget);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byKey(Keys.eventKey), findsNWidgets(3));
        mockData.asMap().forEach((key, value) {
          expect(find.text(key.toString()), findsOneWidget);
        });
      });
    });
  });
}
