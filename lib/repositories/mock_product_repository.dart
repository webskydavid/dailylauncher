import 'package:dailylauncher/models/models.dart';
import 'package:dailylauncher/repositories/product_repository.dart';

class MockProductRepository implements ProductRepository {
  MockProductRepository(this.list);

  List<ProductModel> list = [];

  @override
  Future<ProductModel> readOne(ProductModel product) async {
    print('Mock readOne()');
    await Future.delayed(Duration(milliseconds: 300));
    return list.singleWhere((element) => element.id == product.id);
  }

  @override
  Future<List<ProductModel>> readAll() async {
    print('Mock readAll()');
    await Future.delayed(Duration(milliseconds: 300));
    return list;
  }

  @override
  Future<void> create(ProductModel product) async {
    print('Mock create()');
    await Future.delayed(Duration(milliseconds: 300));
    list.add(product);
  }

  @override
  Future<void> delete(ProductModel product) async {
    print('Mock delete()');
    await Future.delayed(Duration(milliseconds: 300));
    list.remove(product);
  }

  @override
  Future<void> update(ProductModel product) async {
    print('Mock update()');
    await Future.delayed(Duration(milliseconds: 300));
    list.map((element) {
      if (element.id == product.id) {
        return product;
      }
      return element;
    });
  }
}
