import 'package:dailylauncher/models/models.dart';
import 'package:dailylauncher/providers/product_provider.dart';
import 'package:dailylauncher/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  AsyncValue<List> products = watch(productsProvider.state);
                  return products.when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (_, i) => ProductWidget(
                          product: data[i],
                        ),
                      );
                    },
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (e, t) => Text('error $e'),
                  );
                },
              ),
            ),
            Consumer(
              builder: (context, watch, child) {
                AsyncValue<Map<String, dynamic>> counter =
                    watch(productCounterProvider);
                return counter.when(
                  loading: () => Container(),
                  error: (error, stack) =>
                      Text('Oops, something unexpected happened'),
                  data: (value) => Text('${value['done']}/${value['all']}'),
                );
              },
            )
          ],
        ));
  }
}
