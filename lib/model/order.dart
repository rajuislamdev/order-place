class OrderData {
  final int userId;
  final List<ProductData> products;

  OrderData({
    required this.userId,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class ProductData {
  final int? id;
  final int? quantity;

  ProductData({
    required this.id,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}
