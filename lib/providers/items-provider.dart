import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';

enum Sort { asc, desc }

class Item {
  Item({this.id, this.name, this.done = false});
  String id;
  String name;
  bool done;

  @override
  String toString() {
    return '$id - $name';
  }
}

final listFilter = StateProvider<String>((_) => '');
final listSort = StateProvider((_) => Sort.asc);

final boxProvider = FutureProvider.autoDispose((ref) async {
  await Future.delayed(Duration(milliseconds: 1000));
  return await Hive.openBox('item');
});

final listStateNotifierProvider = StateNotifierProvider.autoDispose((ref) {
  return ref.watch(boxProvider).when(
        data: (data) {
          print('when().data');
          ItemList itemList = ItemList(data)..getAll();
          return itemList;
        },
        loading: () => ItemList(null),
        error: (e, t) => ItemList(null),
      );
});

final sortedProvider = Provider.autoDispose((ref) {
  List list = ref.watch(listStateNotifierProvider.state);
  Sort sort = ref.watch(listSort).state;
  String filter = ref.watch(listFilter).state;

  if (sort == Sort.desc) {
    list.sort((a, b) => a['name'].compareTo(b['name']));
  } else {
    list.sort((a, b) => b['name'].compareTo(a['name']));
  }

  return list.where((element) => element['name'].contains(filter)).toList();
});

final listCount = Provider.autoDispose<int>((ref) {
  List list = ref.watch(listStateNotifierProvider.state);
  return list.length;
});

class ItemList extends StateNotifier<List<dynamic>> {
  Box box;
  ItemList(this.box) : super([]);

  void remove(item) async {
    await box.delete(item['id']);
    getAll();
  }

  void edit(item) async {
    await box.put(item['id'], {
      'id': item['id'],
      'name': 'Bla bla ${DateTime.now().millisecond.toString()}'
    });
    getAll();
  }

  getAll() {
    state = box.values.toList();
  }

  void add() async {
    String id = DateTime.now().millisecond.toString();
    await box.put(id, {'id': id, 'name': 'Name $id'});
    getAll();
  }
}
