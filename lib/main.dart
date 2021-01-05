import 'package:dailylauncher/widgets/root_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coś',
      darkTheme: ThemeData.dark(),
      home: RootWidget(),
    );
  }
}
