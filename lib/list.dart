import 'package:dailylauncher/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class ListWidget extends ConsumerWidget {
  const ListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final List<Item> itemList = watch(sortedList);
    watch(sortProvider);
    return Expanded(
      child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return ItemWidget(item: itemList[index]);
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

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(item.id),
            SizedBox(
              width: 10,
            ),
            Text(item.name),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => context.read(listProvider).remove(item),
              color: Colors.red[300],
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () => context.read(listProvider).edit(item),
              color: Colors.blue[300],
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ],
    );
  }
}
