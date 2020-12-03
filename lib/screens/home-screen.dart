import 'package:dailylauncher/providers/items-provider.dart';
import 'package:dailylauncher/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: TitleWidget(),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        print(0);
                        context.read(listFilter).state = value;
                      },
                    ),
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(listStateNotifierProvider).add();
          },
          tooltip: 'Add',
          child: Icon(Icons.add),
        ),
      ),
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
