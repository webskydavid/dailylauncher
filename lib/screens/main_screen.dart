import 'package:dailylauncher/screens/screens.dart';
import 'package:flutter/material.dart';

class Keys {
  static Key eventKey = Key('event_key');
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('MainScreen'),
    );
  }
}
