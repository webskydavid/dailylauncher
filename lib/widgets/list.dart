import 'package:dailylauncher/providers/items-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';

class ListWidget extends ConsumerWidget {
  const ListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    var list = watch(sortedProvider);
    watch(listSort);

    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ItemWidget(item: list[index]);
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key key,
    @required this.item,
  }) : super(key: key);

  final item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(item['id']),
            SizedBox(
              width: 10,
            ),
            Text(item['name']),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () =>
                  context.read(listStateNotifierProvider).remove(item),
              color: Colors.red[300],
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () =>
                  context.read(listStateNotifierProvider).edit(item),
              color: Colors.blue[300],
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ],
    );
  }
}
