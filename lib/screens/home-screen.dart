import 'package:dailylauncher/providers/items-provider.dart';
import 'package:dailylauncher/widgets/form.dart';
import 'package:dailylauncher/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: TitleWidget(),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Search by name'),
                onChanged: (value) {
                  print(0);
                  context.read(listFilter).state = value;
                },
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (context.read(listSort).state == Sort.asc) {
                        context.read(listSort).state = Sort.desc;
                      } else {
                        context.read(listSort).state = Sort.asc;
                      }
                    },
                    icon: Icon(Icons.sort),
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      int count = watch(listCount);
                      return Text('Items: $count');
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              Consumer(builder: (context, watch, child) {
                final box = watch(boxProvider);
                return box.when(
                  data: (data) => ListWidget(),
                  loading: () => CircularProgressIndicator(),
                  error: (e, t) => Text(e.toString()),
                );
              }),
              Consumer(
                builder: (context, watch, child) {
                  int sum = watch(priceSum);
                  return Text(
                    'Items: $sum zł',
                    style: TextStyle(fontSize: 20.0),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Consumer(builder: (context, watch, child) {
          final show = watch(showFloatingButtonProvider).state;
          return show ? FloatingButton() : Container();
        }),
      ),
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showBottomSheet(
          elevation: 16,
          context: context,
          builder: (_) {
            return Wrap(children: [
              FormWidget(item: {'name': '', 'price': ''})
            ]);
          },
        );

        context.read(showFloatingButtonProvider).state = false;
      },
      tooltip: 'Add',
      child: Icon(Icons.add),
    );
  }
}

final titleProvider = Provider<String>((_) {
  return 'Title / Provider';
});

class TitleWidget extends ConsumerWidget {
  const TitleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final title = watch(titleProvider);
    return Text(title);
  }
}
