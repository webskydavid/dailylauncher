import 'package:flutter_riverpod/all.dart';
import 'package:uuid/uuid.dart';

final uuidProvider = StateProvider<Function>((ref) {
  Uuid uuid = Uuid();
  return () => uuid.v1();
});
