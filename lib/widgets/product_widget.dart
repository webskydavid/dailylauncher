import 'package:dailylauncher/models/models.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  ProductWidget({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(product.id),
          SizedBox(width: 10.0),
          Text(product.name),
          SizedBox(width: 10.0),
          Text(product.price),
          SizedBox(width: 10.0),
          Text(product.amount),
        ],
      ),
    );
  }
}
