import 'package:flutter/material.dart';

class ScreenModel {
  final String title;
  final Icon icon;
  final Icon appBarIcon;
  final Widget floatingActionWidget;
  final Widget screenWidget;

  ScreenModel(this.title, this.icon, this.appBarIcon, this.floatingActionWidget,
      this.screenWidget);
}
