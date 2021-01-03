import 'package:flutter/material.dart';

class Keys {
  static Key event_key = Key('event_key');
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.calendar_today),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Text('0', key: Keys.event_key),
            Text('1', key: Keys.event_key),
            Text('2', key: Keys.event_key),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
