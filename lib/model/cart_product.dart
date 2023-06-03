class CartProduct {
  late int id;
  String? title;
  int? price;
  int? quantity;
  int? total;
  double? discountPercentage;
  int? discountedPrice;

  CartProduct(
      {required this.id,
      this.title,
      this.price,
      this.quantity,
      this.total,
      this.discountPercentage,
      this.discountedPrice});

  CartProduct.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
    discountPercentage = json['discountPercentage'];
    discountedPrice = json['discountedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['quantity'] = quantity;
    data['total'] = total;
    data['discountPercentage'] = discountPercentage;
    data['discountedPrice'] = discountedPrice;
    return data;
  }
}
