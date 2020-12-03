import 'package:hive/hive.dart';

class ItemsService {
  bool busy;
  Box box;

  init() async {
    box = await Hive.openBox('item');
  }

  getAll() {
    return box.values.toList();
  }

  create() async {
    busy = true;
    String id = DateTime.now().millisecond.toString();
    await box.put(id, {'id': id, 'name': 'Name $id'});
    busy = false;
  }
}
