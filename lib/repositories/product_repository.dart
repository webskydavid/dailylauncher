import 'package:dailylauncher/models/product_model.dart';

abstract class IProductRepository {
  Future<ProductModel> readOne(ProductModel product);
  Future<List<ProductModel>> readAll();
  Future<void> create(ProductModel product);
  Future<void> update(ProductModel product);
  Future<void> delete(ProductModel product);
}

class ProductRepository implements IProductRepository {
  @override
  Future<void> create(ProductModel product) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(ProductModel product) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<ProductModel> readOne(ProductModel product) {
    // TODO: implement readOne
    throw UnimplementedError();
  }

  @override
  Future<void> update(ProductModel product) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
