import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';

enum Sort { asc, desc }

class Item {
  String id;
  String name;
  double price;
  bool done;
  DateTime created;
  DateTime updated;
  int amount;
  List<int> tags;
  String shop;

  Item({
    this.id,
    this.name,
    this.price,
    this.done,
    this.created,
    this.updated,
    this.amount,
    this.tags,
    this.shop,
  }) {
    this.id = id ?? '';
    this.name = name ?? '';
    this.price = price ?? 0.0;
    this.done = done ?? false;
    this.created = created ?? DateTime.now();
    this.updated = updated ?? DateTime.now();
    this.amount = amount ?? 1;
    this.tags = tags ?? [];
    this.shop = shop ?? '';
  }

  Item.fromMap(Map<dynamic, dynamic> map) {
    print(map['created']);
    id = map['id'];
    name = map['name'];
    price = double.parse(map['price'] ?? '0.0');
    done = map['done'];
    created = DateTime.parse(map['created']);
    updated = DateTime.parse(map['updated']);
    amount = map['amount'];
    tags = map['tags'];
    shop = map['shop'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price.toString();
    data['done'] = this.done;
    data['created'] = this.created.toString();
    data['updated'] = this.updated.toString();
    data['amount'] = this.amount;
    data['tags'] = this.tags;
    data['shop'] = this.shop;
    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}

final listFilter = StateProvider<String>((ref) {
  print(ref.container.debugProviderValues);
  return '';
});

final listSort = StateProvider((_) => Sort.asc);

final listStateNotifierProvider = StateNotifierProvider<ItemList>((ref) {
  return ItemList();
});

final sortedProvider = Provider<AsyncValue<List<Item>>>((ref) {
  final AsyncValue<List<Item>> list =
      ref.watch(listStateNotifierProvider.state);
  Sort sort = ref.watch(listSort).state;
  String filter = ref.watch(listFilter).state;

  AsyncValue<List<Item>> result = list.whenData(
    (value) {
      var done = value.where((element) => element.done).toList();
      var undone = value.where((element) => !element.done).toList();

      if (sort == Sort.desc) {
        done.sort((a, b) => a.name.compareTo(b.name));
        undone.sort((a, b) => a.name.compareTo(b.name));
      } else {
        done.sort((a, b) => b.name.compareTo(a.name));
        undone.sort((a, b) => b.name.compareTo(a.name));
      }

      return [...undone, ...done];
    },
  );

  return result.whenData((value) => value
      .where((element) =>
          element.name.toLowerCase().contains(filter.toLowerCase()))
      .toList());
});

final listCount = Provider<AsyncValue<Map<String, int>>>((ref) {
  AsyncValue<List<Item>> list = ref.watch(listStateNotifierProvider.state);
  return list.whenData((value) => ({
        'done': value.where((element) => element.done).length ?? 0,
        'undone': value.where((element) => !element.done).length ?? 0,
      }));
});

final priceSum = Provider.autoDispose<double>((ref) {
  double sum = 0.0;
  AsyncValue<List<Item>> list = ref.watch(listStateNotifierProvider.state);
  list.whenData((value) => value.forEach((value) {
        print(value.price);
        sum = sum + value.price;
      }));
  return sum;
});

class ItemList extends StateNotifier<AsyncValue<List<Item>>> {
  Box box;
  ItemList([AsyncValue<List<Item>> items])
      : super(items ?? AsyncValue.loading()) {
    _init();
  }

  _init() async {
    print('init()');
    box = await Hive.openBox('item');
    //Hive.deleteBoxFromDisk('item');
    getAll();
  }

  Future<void> getAll() async {
    try {
      print('getAll()');
      await Future.delayed(Duration(milliseconds: 200));
      state = AsyncValue.data(
        box.values.map((item) {
          print(item);
          return Item.fromMap(item);
        }).toList(),
      );
    } catch (e, t) {
      state = AsyncValue.error('getAll() $e, $t', t);
    }
  }

  void remove(Item item) async {
    state = AsyncValue.loading();
    await box.delete(item.id);
    getAll();
  }

  void edit(Item item) async {
    state = AsyncValue.loading();
    await box.put(item.id, item.toMap());
    print('Edit() $item');
    getAll();
  }

  void add(Item item) async {
    state = AsyncValue.loading();
    int id = DateTime.now().millisecond;
    String idStr = id.toString();
    item.id = idStr;
    print('add() $item');
    await box.put(idStr, item.toMap());
    getAll();
  }

  void toggle(String id) async {
    state = AsyncValue.loading();
    var item = Item.fromMap(box.get(id));
    item.done = !item.done;
    item.updated = DateTime.now();
    await box.put(id, item.toMap());
    getAll();
  }
}

final showFloatingButtonProvider = StateProvider<bool>((ref) {
  return true;
});

final activeItemInputProvider = StateProvider<String>((ref) {
  return '';
});
