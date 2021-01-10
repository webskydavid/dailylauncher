import 'package:dailylauncher/screens/screens.dart';
import 'package:dailylauncher/widgets/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/models.dart';

void main() {
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coś',
      darkTheme: ThemeData.dark(),
      home: RootWidget(Screens.list),
    );
  }
}

class Screens {
  static List<ScreenModel> list = [
    ScreenModel(
      'Today',
      Icon(Icons.event),
      Icon(Icons.calendar_today),
      Text('Event add'),
      EventsScreen(),
    ),
    ScreenModel(
      'Grocery',
      Icon(Icons.shopping_cart),
      Icon(Icons.menu),
      AddProductScreen(),
      ShoppingListScreen(),
    ),
  ];
}
