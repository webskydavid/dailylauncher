import 'package:dailylauncher/models/models.dart';
import 'package:dailylauncher/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFormWidget extends StatefulWidget {
  ProductFormWidget({Key key}) : super(key: key);

  @override
  _ProductFormWidgetState createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String price = '0.0';
  String amount = '1';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ProviderListener(
            onChange: (_, AsyncValue v) {
              if (v is AsyncData) {
                SnackBar snackBar = SnackBar(content: Text('Product added'));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            provider: productsProvider.state,
            child: Container(),
          ),
          TextFormField(
            initialValue: name,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value.trim().isEmpty) {
                return 'Name is required';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                name = value;
              });
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
            onChanged: (value) {
              setState(() {
                price = value;
              });
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
            onChanged: (value) {
              setState(() {
                amount = value;
              });
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                context.read(productsProvider).create(
                      ProductModel(
                        name: name,
                        price: price,
                        amount: amount,
                      ),
                    );
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
