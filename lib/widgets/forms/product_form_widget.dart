import 'package:flutter/material.dart';

class ProductFormWidget extends StatelessWidget {
  ProductFormWidget({Key key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: '',
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: '0.0',
            decoration: InputDecoration(labelText: 'Price'),
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'Price is required';
              }
              return null;
            },
          ),
          TextFormField(
            initialValue: '1',
            decoration: InputDecoration(labelText: 'Amount'),
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'Amount is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                SnackBar snackBar = SnackBar(content: Text('Product added'));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }
}
