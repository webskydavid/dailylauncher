import 'package:dailylauncher/items.dart';
import 'package:dailylauncher/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleProvider = Provider<String>((_) {
  return 'Title / Provider';
});

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
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
                      if (context.read(sortProvider).state == Sort.asc) {
                        context.read(sortProvider).state = Sort.desc;
                      } else {
                        context.read(sortProvider).state = Sort.asc;
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
                ],
              ),
              ListWidget(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(listProvider).add('Foo');
          },
          tooltip: 'Add',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

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
