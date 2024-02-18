class Product {
  final int id;
  final String title;
  final int price;
  final bool vb;
  final String location;
  final bool shipping;

  Product(this.id, this.title, this.price, this.vb, this.location, this.shipping);

factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['product_id'],
      json['product_title'],
      json['product_price'],
      json['product_vb'] == 0 ? false : true,
      json['product_location'],
      json['product_shipping'] == 0 ? false : true,
    );
  }
}