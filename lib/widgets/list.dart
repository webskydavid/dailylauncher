import 'package:dailylauncher/providers/items-provider.dart';
import 'package:dailylauncher/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class ListWidget extends ConsumerWidget {
  const ListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    var list = watch(sortedProvider);
    watch(listSort);
    bool isDivider = false;
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (list[index]['done'] && !isDivider) {
            isDivider = true;
            return Column(
              children: [Divider(), ItemWidget(item: list[index])],
            );
          }

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
        Checkbox(
          value: item['done'] ?? false,
          onChanged: (value) {
            context.read(listStateNotifierProvider).toggle(item['id']);
          },
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['id']),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  item['name'],
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${(item['price'] ?? '0')} zł',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
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
              onPressed: () {
                showBottomSheet(
                  elevation: 16,
                  context: context,
                  builder: (_) {
                    return Wrap(children: [
                      FormWidget(
                        item: {
                          'id': item['id'],
                          'name': item['name'],
                          'done': item['done'],
                          'price': item['price']
                        },
                      )
                    ]);
                  },
                );
                context.read(showFloatingButtonProvider).state = false;
              },
              color: Colors.blue[300],
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ],
    );
  }
}
