import 'package:flutter/material.dart';

class AddGroceryScreen extends StatelessWidget {
  const AddGroceryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text('Add Grocery'), BackButton()],
        ),
      ),
    );
  }
}
