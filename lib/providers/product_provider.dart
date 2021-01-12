// PRODUCT LIST CLASS
import 'package:dailylauncher/models/models.dart';
import 'package:dailylauncher/providers/providers.dart';
import 'package:dailylauncher/repositories/repository.dart';
import 'package:flutter_riverpod/all.dart';

class ProductList extends StateNotifier<AsyncValue<List<ProductModel>>> {
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
    state = AsyncValue.loading();
    product.id = uuidProvider();
    await productRepository.create(product);
    await getAll();
  }

  Future<void> update(ProductModel product) async {
    state = AsyncValue.loading();
    await productRepository.update(product);
    await getAll();
  }
}

// REPOSITORY
// ignore: todo
// TODO: Remove Mock
final productRepositoryProvider =
    Provider<ProductRepository>((ref) => MockProductRepository([]));

// UI PROVIDERS
final productsProvider = StateNotifierProvider<ProductList>((ref) {
  var productRepository = ref.read(productRepositoryProvider);
  var clock = ref.read(uuidProvider).state;
  return ProductList(productRepository, clock);
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
