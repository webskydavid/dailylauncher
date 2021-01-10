// PRODUCT LIST CLASS
import 'package:dailylauncher/models/models.dart';
import 'package:flutter_riverpod/all.dart';

class ProductList extends StateNotifier<AsyncValue<List<ProductModel>>> {
  final List<ProductModel> list = [];
  final clock;
  ProductList(this.clock, [AsyncValue<List<ProductModel>> products])
      : super(products ?? AsyncValue.loading()) {
    _init();
  }

  _init() async {
    await getAll();
  }

  Future<void> getAll() async {
    try {
      await Future.delayed(Duration(milliseconds: 100));
      state = AsyncValue.data(list);
    } catch (e) {
      state = AsyncValue.error('getAll() $e');
    }
  }

  Future<void> add(ProductModel product) async {
    try {
      state = AsyncValue.loading();
      await Future.delayed(Duration(milliseconds: 100));
      product.id = clock();
      list.add(product);
      await getAll();
    } catch (e) {
      state = AsyncValue.error('getAll() $e');
    }
  }
}

// PROVIDERS
final productsProvider = StateNotifierProvider<ProductList>((ref) {
  var clock = ref.watch(clockProvider).state;
  return ProductList(clock);
});

final listOfProductsProvider = Provider<AsyncValue<List<dynamic>>>((ref) {
  final AsyncValue products = ref.watch(productsProvider.state);
  return products;
});

final clockProvider = StateProvider<Function>((ref) {
  return () => DateTime.now().millisecondsSinceEpoch.toString();
});
