import 'package:dailylauncher/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add product'),
        leading: BackButton(),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: ProductFormWidget(),
        ),
      ),
    );
  }
}
