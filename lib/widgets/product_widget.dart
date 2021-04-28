import 'package:dailylauncher/models/models.dart';
import 'package:dailylauncher/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  ProductWidget({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
              value: product.done,
              onChanged: (value) {
                product.done = value;
                context.read(productsProvider).update(product);
              }),
          Text(product.name),
          SizedBox(width: 10.0),
          Text(product.price),
          SizedBox(width: 10.0),
          Text((double.parse(product.price) * int.parse(product.amount))
              .toString()),
          SizedBox(width: 10.0),
          Text(product.amount),
        ],
      ),
    );
  }
}
