import 'package:dailylauncher/models/models.dart';
import 'package:dailylauncher/screens/screens.dart';

import 'package:flutter/material.dart';

List<ScreenModel> screens = [
  ScreenModel(
    'Today',
    Icon(Icons.event),
    Icon(Icons.calendar_today),
    Container(),
  ),
  ScreenModel(
    'Grocery',
    Icon(Icons.shopping_cart),
    Icon(Icons.menu),
    AddGroceryScreen(),
  ),
];

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  int currentTabIndex = 0;
  List<ScreenModel> allScreens = screens;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: currentTabIndex == 0 ? MainScreen() : GroceryScreen(),
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(allScreens[currentTabIndex].title),
      actions: [
        IconButton(
          onPressed: () {},
          icon: allScreens[currentTabIndex].appBarIcon,
        )
      ],
    );
  }

  IconButton _floatingActionButton() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return AddGroceryScreen();
          },
        ));
      },
    );
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTabIndex,
      onTap: (int tabIndex) {
        setState(() {
          currentTabIndex = tabIndex;
        });
      },
      items: allScreens
          .map(
            (e) => BottomNavigationBarItem(icon: e.icon, label: e.title),
          )
          .toList(),
    );
  }
}
