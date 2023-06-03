class CartProduct {
  late int id;
  late String title;
  late int price;
  late int quantity;
  late int total;
  late double discountPercentage;
  late int discountedPrice;

  CartProduct(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity,
      required this.total,
      required this.discountPercentage,
      required this.discountedPrice});

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
