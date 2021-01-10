class ProductModel {
  String id;
  String name;
  String price;
  String amount;
  bool done;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.amount,
    this.done,
  }) {
    this.id = id ?? '';
    this.name = name ?? '';
    this.price = price ?? '0.0';
    this.amount = amount ?? 1;
    this.done = done ?? false;
  }
}
