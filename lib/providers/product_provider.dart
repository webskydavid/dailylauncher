// PRODUCT LIST CLASS
import 'package:dailylauncher/models/models.dart';
import 'package:dailylauncher/providers/providers.dart';
import 'package:dailylauncher/repositories/repository.dart';
import 'package:flutter_riverpod/all.dart';

class ProductList extends StateNotifier<AsyncValue<List<ProductModel>>> {
  // TODO: Add cache to store prevous data, load to state the whenData result
  final ProductRepository productRepository;
  final Function uuidProvider;

  ProductList(this.productRepository, this.uuidProvider,
      [AsyncValue<List<ProductModel>> products])
      : super(products ?? AsyncValue.loading()) {
    _init();
  }

  _init() async {
    await getAll();
  }

  Future<void> getAll() async {
    List result = await productRepository.readAll();
    state = AsyncValue.data(result);
  }

  Future<void> create(ProductModel product) async {
    product.id = uuidProvider();
    state = state.whenData((value) => [...value]..add(product));
    await productRepository.create(product);
  }

  Future<void> update(ProductModel product) async {
    await productRepository.update(product);
    state = state.whenData(
      (value) => value.map((item) {
        if (item.id == product.id) {
          return product;
        }
        return item;
      }).toList(),
    );
  }
}

// REPOSITORY
// ignore: todo
// TODO: Remove Mock
final productRepositoryProvider =
    Provider<ProductRepository>((ref) => MockProductRepository([]));

// UI PROVIDERS
final productsProvider = StateNotifierProvider<ProductList>((ref) {
  var productRepository = ref.watch(productRepositoryProvider);
  var uuid = ref.read(uuidProvider).state;
  return ProductList(productRepository, uuid);
});

final listOfProductsProvider = Provider<AsyncValue<List<ProductModel>>>((ref) {
  final AsyncValue products = ref.watch(productsProvider.state);

  return products;
});

final productCounterProvider =
    Provider<AsyncValue<Map<String, dynamic>>>((ref) {
  final AsyncValue<List<ProductModel>> products =
      ref.watch(productsProvider.state);
  return products.whenData((value) {
    return {
      'done': value.where((element) => element.done).length,
      'all': value.length
    };
  });
});
