import 'package:dailylauncher/models/models.dart';
import 'package:flutter/material.dart';

class RootWidget extends StatefulWidget {
  final List<ScreenModel> screens;

  RootWidget(this.screens);

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: widget.screens[currentTabIndex].screenWidget,
      floatingActionButton: _floatingActionButton(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: BackButton(),
      title: Text(widget.screens[currentTabIndex].title),
      actions: [
        IconButton(
          onPressed: () {},
          icon: widget.screens[currentTabIndex].appBarIcon,
        )
      ],
    );
  }

  IconButton _floatingActionButton() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                widget.screens[currentTabIndex].floatingActionWidget,
          ),
        );
      },
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentTabIndex,
      onTap: (int tabIndex) {
        setState(() {
          currentTabIndex = tabIndex;
        });
      },
      items: widget.screens
          .map(
            (e) => BottomNavigationBarItem(icon: e.icon, label: e.title),
          )
          .toList(),
    );
  }
}
