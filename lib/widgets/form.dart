import 'package:dailylauncher/providers/items-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class FormWidget extends StatefulWidget {
  FormWidget({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final FocusNode node = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String name;
  String price;
  String amount;
  String shop;
  String tags;

  @override
  void initState() {
    super.initState();
    this.name = widget.item.name;
    this.price = widget.item.price.toString();
    this.amount = widget.item.price.toString();
    this.shop = widget.item.shop;
    this.tags = widget.item.tags.join(',');
  }

  @override
  Widget build(BuildContext context) {
    print(widget.item);
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.item.id != ''
                ? Text(
                    'Editing',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text('Create new item:'),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    initialValue: widget.item.name,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == '') {
                        return 'Empty value';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      this.name = value;
                    },
                    autofocus: true,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Flexible(
                  child: TextFormField(
                    initialValue: widget.item.shop,
                    decoration: InputDecoration(labelText: 'Shop'),
                    validator: (value) {
                      if (value == '') {
                        return 'Empty value';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      this.shop = value;
                    },
                    autofocus: true,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Flexible(
                  child: TextFormField(
                    initialValue: widget.item.tags.join(','),
                    decoration: InputDecoration(labelText: 'Tags'),
                    validator: (value) {
                      if (value == '') {
                        return 'Empty value';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      this.tags = value;
                    },
                    autofocus: true,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    initialValue: widget.item.price.toString(),
                    decoration: InputDecoration(labelText: 'Price'),
                    validator: (value) {
                      if (value == '') {
                        return 'Empty value';
                      }
                      double number = double.tryParse(value);
                      if (number == null) {
                        return 'No digits';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      this.price = value;
                    },
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Flexible(
                  child: TextFormField(
                    initialValue: widget.item.amount.toString(),
                    decoration: InputDecoration(labelText: 'Amount'),
                    validator: (value) {
                      if (value == '') {
                        return 'Empty value';
                      }
                      int number = int.tryParse(value);
                      if (number == null) {
                        return 'No digits';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      this.amount = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Consumer(builder: (_, watch, child) {
              return Column(
                children: [
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _.read(showFloatingButtonProvider).state = true;
                        print('item ${widget.item}');
                        if (widget.item.id != '') {
                          _.read(listStateNotifierProvider).edit(Item(
                                id: widget.item.id,
                                name: name,
                                done: widget.item.done,
                                price: double.parse(price),
                                shop: shop,
                                tags: tags
                                    .split(',')
                                    .map((tag) => int.parse(tag))
                                    .toList(),
                              ));
                        } else {
                          _.read(listStateNotifierProvider).add(
                                Item(
                                  name: name,
                                  price: double.parse(price),
                                  amount: int.parse(amount),
                                  shop: shop,
                                  tags: tags
                                      .split(',')
                                      .map((tag) => int.parse(tag))
                                      .toList(),
                                ),
                              );
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: widget.item.id != '' ? Text('Save') : Text('Create'),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      _.read(showFloatingButtonProvider).state = true;
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
