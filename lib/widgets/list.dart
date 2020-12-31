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
    return list.when(
      data: (data) => Expanded(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            if (data[index].done && !isDivider) {
              isDivider = true;
              return Column(
                children: [Divider(), ItemWidget(item: data[index])],
              );
            }

            return ItemWidget(item: data[index]);
          },
        ),
      ),
      loading: () => CircularProgressIndicator(),
      error: (e, t) => Text('Error'),
    );
  }
}

class ItemWidget extends StatefulWidget {
  const ItemWidget({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool showInput = false;
  FocusNode focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _checkbox(context),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _id(),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _name(context),
                    Row(
                      children: [
                        _created(),
                        _amount(),
                        SizedBox(width: 20.0),
                        _shop(),
                        ..._tags()
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        _price(),
        _actions(context),
      ],
    );
  }

  Row _actions(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () =>
              context.read(listStateNotifierProvider).remove(widget.item),
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
                    item: widget.item,
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
    );
  }

  Text _price() {
    return Text(
      '${(widget.item.price ?? '0')} zł',
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Text _shop() => Text('Shop: ${widget.item.shop}');

  Text _created() => Text(widget.item.updated.toString());

  Text _amount() => Text('Amount: ${widget.item.amount.toString()}');

  List<Widget> _tags() {
    return widget.item.tags
        .map((tag) => Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.blue.shade400,
            ),
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(3),
            child: Text(
              tag.toString(),
              style: TextStyle(color: Colors.white),
            )))
        .toList();
  }

  GestureDetector _name(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          //showInput = true;
          focus.requestFocus();
          context.read(activeItemInputProvider).state = widget.item.id;
        });
      },
      child: Consumer(
        builder: (context, watch, child) {
          String id = watch(activeItemInputProvider).state;
          return id == widget.item.id
              ? TextFormField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    focusColor: Colors.grey.shade100,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                    isDense: true,
                  ),
                  initialValue: widget.item.name,
                  autofocus: true,
                  focusNode: focus,
                  onEditingComplete: () {
                    print('fwefe');
                  },
                )
              : Text(
                  widget.item.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
        },
      ),
    );
  }

  Text _id() => Text(widget.item.id);

  Checkbox _checkbox(BuildContext context) {
    return Checkbox(
      value: widget.item.done ?? false,
      onChanged: (value) {
        context.read(listStateNotifierProvider).toggle(widget.item.id);
      },
    );
  }
}
