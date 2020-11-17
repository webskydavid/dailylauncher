import 'package:flutter_riverpod/all.dart';

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

final sortProvider = StateProvider<Sort>((ref) {
  print(ref.container.debugProviderValues);

  return Sort.asc;
});

final listProvider = StateNotifierProvider<ItemList>((ref) {
  return ItemList([
    Item(id: '1', name: 'Test 1'),
    Item(id: '2', name: 'Test 2'),
    Item(id: '3', name: 'Test 3'),
  ]);
});

final sortedListProvider = Provider<List<Item>>((ref) {
  final sort = ref.watch(sortProvider).state;
  final list = ref.watch(listProvider.state);
  if (sort == Sort.asc) {
    list.sort((a, b) => a.name.compareTo(b.name));
  } else if (sort == Sort.desc) {
    list.sort((a, b) => b.name.compareTo(a.name));
  }
  return list;
});

final listCountProvider = Provider<int>((ref) {
  return ref.watch(listProvider.state).length;
});

class ItemList extends StateNotifier<List<Item>> {
  ItemList([List<Item> initList]) : super(initList ?? []);

  void add(String name) async {
    await Future.delayed(Duration(milliseconds: 1000));
    state = [
      ...state,
      Item(
        id: DateTime.now().millisecondsSinceEpoch.toString().substring(8),
        name: name,
      )
    ];
  }

  void remove(Item item) async {
    await Future.delayed(Duration(milliseconds: 500));
    state = state.where((element) => element.id != item.id).toList();
  }

  void edit(Item item) async {
    await Future.delayed(Duration(milliseconds: 500));
    state = state.map((element) {
      if (element.id == item.id) {
        return Item(id: item.id, name: '+ ${item.name}');
      }
      return element;
    }).toList();
  }
}
