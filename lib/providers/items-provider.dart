import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';

enum Sort { asc, desc }

class Item {
  Item({
    id,
    name,
    done,
    created,
    updated,
  })  : done = done ?? false,
        created = created ?? DateTime.now(),
        updated = updated ?? DateTime.now();

  String id;
  String name;
  bool done;
  DateTime created;
  DateTime updated;

  @override
  String toString() {
    return '$id - $name';
  }
}

final listFilter = StateProvider<String>((ref) {
  print(ref.container.debugProviderValues);
  return '';
});

final listSort = StateProvider((_) => Sort.asc);

final boxProvider = FutureProvider.autoDispose((ref) async {
  await Future.delayed(Duration(milliseconds: 1000));
  //Hive.deleteBoxFromDisk('item');
  return await Hive.openBox('item');
});

final listStateNotifierProvider = StateNotifierProvider.autoDispose((ref) {
  return ref.watch(boxProvider).when(
        data: (data) {
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

  List done = list.where((element) => element['done']).toList();
  List undone = list.where((element) => !element['done']).toList();

  if (sort == Sort.desc) {
    done.sort((a, b) => a['name'].compareTo(b['name']));
    undone.sort((a, b) => a['name'].compareTo(b['name']));
  } else {
    done.sort((a, b) => b['name'].compareTo(a['name']));
    undone.sort((a, b) => b['name'].compareTo(a['name']));
  }

  List mergedList = [...undone, ...done];

  return mergedList
      .where((element) => element['name'].contains(filter))
      .toList();
});

final listCount = Provider.autoDispose<int>((ref) {
  List list = ref.watch(listStateNotifierProvider.state);
  return list.length;
});

final priceSum = Provider.autoDispose<int>((ref) {
  int sum = 0;
  List list = ref.watch(listStateNotifierProvider.state);
  list.forEach((value) {
    sum = sum + int.parse(value['price']);
  });
  return sum;
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
      'name': item['name'],
      'done': item['done'],
      'price': item['price'],
    });
    print('Edit() $item');
    getAll();
  }

  getAll() {
    state = box.values.toList();
    print(state);
  }

  void add(item) async {
    int id = DateTime.now().millisecond;
    String idStr = id.toString();

    await box.put(idStr, {
      'id': idStr,
      'name': item['name'],
      'done': false,
      'price': item['price']
    });
    getAll();
  }

  void toggle(String id) async {
    var item = box.get(id);
    await box.put(id, {
      'id': item['id'],
      'name': item['name'],
      'done': !item['done'],
      'price': item['price'],
    });
    getAll();
  }
}

final showFloatingButtonProvider = StateProvider<bool>((ref) {
  return true;
});
