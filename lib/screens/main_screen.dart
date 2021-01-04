import 'package:dailylauncher/screens/screens.dart';
import 'package:flutter/material.dart';

class Keys {
  static Key eventKey = Key('event_key');
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
            Text('0', key: Keys.eventKey),
            Text('1', key: Keys.eventKey),
            Text('2', key: Keys.eventKey),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int tabIndex) {
          if (tabIndex == 0) {
          } else if (tabIndex == 1) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return ShoppingListScreen();
              },
            ));
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: 'Grocary'),
        ],
      ),
    );
  }
}
