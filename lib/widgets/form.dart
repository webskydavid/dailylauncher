import 'package:dailylauncher/providers/items-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';

class FormWidget extends StatefulWidget {
  FormWidget({Key key, this.item}) : super(key: key);

  final Map<String, dynamic> item;

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final FocusNode node = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String name;
  String price;

  @override
  void initState() {
    super.initState();
    this.name = widget.item['name'];
    this.price = widget.item['price'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.item.containsKey('id')
                ? Text(
                    'Editing',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text('Create new item:'),
            TextFormField(
              initialValue: widget.item['name'],
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
            TextFormField(
              initialValue: widget.item['price'],
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                        if (widget.item.containsKey('id')) {
                          _.read(listStateNotifierProvider).edit({
                            'id': widget.item['id'],
                            'name': name,
                            'done': widget.item['done'],
                            'price': price
                          });
                        } else {
                          _.read(listStateNotifierProvider).add(
                            {'name': name, 'price': price},
                          );
                        }
                        print(widget.item.containsKey('id'));
                        Navigator.pop(context);
                      }
                    },
                    child: widget.item.containsKey('id')
                        ? Text('Save')
                        : Text('Create'),
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
