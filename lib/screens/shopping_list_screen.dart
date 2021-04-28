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
            Consumer(
              builder: (context, watch, child) {
                final filter = watch(filterProvider);
                print(filter.state);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      child: Text('All'),
                      onPressed: () {
                        filter.state = Filter.all;
                      },
                      color: Filter.all == filter.state
                          ? Colors.blue
                          : Colors.grey.shade800,
                    ),
                    SizedBox(width: 5.0),
                    RaisedButton(
                      child: Text('Done'),
                      onPressed: () {
                        filter.state = Filter.done;
                      },
                      color: Filter.done == filter.state
                          ? Colors.blue
                          : Colors.grey.shade800,
                    ),
                    SizedBox(width: 5.0),
                    RaisedButton(
                      child: Text('Undone'),
                      onPressed: () {
                        filter.state = Filter.undone;
                      },
                      color: Filter.undone == filter.state
                          ? Colors.blue
                          : Colors.grey.shade800,
                    )
                  ],
                );
              },
            ),
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  AsyncValue<List> products =
                      watch(filteredProductsProvider).state;
                  print(products);
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
