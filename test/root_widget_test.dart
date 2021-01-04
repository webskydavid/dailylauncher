import 'package:dailylauncher/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dailylauncher/main.dart';

void main() {
  Widget rootWidget;

  setUpAll(() {
    rootWidget = RootWidget();
  });

  group('RootWidget on initialize', () {
    testWidgets('should show MainScreen', (WidgetTester tester) async {
      await tester.pumpWidget(rootWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(MainScreen), findsOneWidget);
    });
  });
}
