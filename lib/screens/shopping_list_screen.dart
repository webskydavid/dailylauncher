import 'package:dailylauncher/providers/product_provider.dart';
import 'package:dailylauncher/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer(
      builder: (context, watch, child) {
        AsyncValue<List> products = watch(listOfProductsProvider);
        return products.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, i) => ProductWidget(
                product: data[i],
              ),
            );
          },
          loading: () => CircularProgressIndicator(),
          error: (e, t) => Text('error $e'),
        );
      },
    ));
  }
}
