import 'package:flutter/material.dart';

class Keys {
  static Key eventKey = Key('event_key');
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Text('1'),
          Text('1'),
          Text('1'),
          Text('1'),
        ],
      ),
    );
  }
}
