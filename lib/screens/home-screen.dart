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
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          context.read(activeItemInputProvider).state = '';
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
                    Flexible(
                      child: TextField(
                        decoration:
                            InputDecoration(labelText: 'Search by name'),
                        onChanged: (value) {
                          print(0);
                          context.read(listFilter).state = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                ListWidget(),
                Consumer(
                  builder: (context, watch, child) {
                    AsyncValue<Map<String, int>> count = watch(listCount);
                    return count.when(
                      data: (value) {
                        print(value);
                        return Text(
                            'Items ${value['undone']} / ${value['done']}');
                      },
                      loading: () => Container(),
                      error: (e, t) => Text(e.toString()),
                    );
                  },
                ),
                Consumer(
                  builder: (context, watch, child) {
                    double sum = watch(priceSum);
                    return Text(
                      'Sum: $sum zł',
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
            return Wrap(children: [FormWidget(item: Item())]);
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
