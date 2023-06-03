// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/model/cart_product.dart';
import 'package:place_order/model/order.dart';
import 'package:place_order/model/product.dart';
import 'package:place_order/util/app_constants.dart';
import 'package:place_order/utils/api_client.dart';

class ProductProvider extends ChangeNotifier {
  final Ref ref;

  ProductProvider(this.ref);
  bool isLoading = false;

  List<Products> _productList = [];
  List<Products> get productList => _productList;

  List<CartProduct> _cartProductList = [];
  List<CartProduct> get cartProductList => _cartProductList;

  int quantity = 0;
  int totalProudctPrice = 0;
  Future<bool> getProducts() async {
    isLoading = true;
    notifyListeners();
    final response =
        await ref.read(apiClientProvider).get(AppConstant.allProductUrl);
    if (response.statusCode == 200) {
      _productList = response.data['products']
          .map<Products>((product) => Products.fromMap(product))
          .toList();
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> addToCartProduct(
      {required OrderData orderData, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    final response = await ref.read(apiClientProvider).post(
          AppConstant.addToCartProudctUrl,
          data: orderData.toJson(),
        );
    if (response.statusCode == 200) {
      const snackbar = SnackBar(
        content: Text('Product successfully added!'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> getCartProducts({required int userId}) async {
    final response = await ref
        .read(apiClientProvider)
        .get('${AppConstant.cartProudctsUrl}/$userId');
    if (response.statusCode == 200) {
      _cartProductList = response.data['carts'][0]['products']
          .map<CartProduct>(
            (product) => CartProduct.fromMap(product),
          )
          .toList();
      return true;
    }
    return false;
  }

  Future<bool> deleteCarts({required int id}) async {
    final response = await ref
        .read(apiClientProvider)
        .delete('${AppConstant.deleteCartsUrl}/$id');
    print(response.data);
    if (response.statusCode == 200) {
      print(response.data);
      return true;
    }
    return false;
  }

  Future<bool> serachProducts({required String searchKey}) async {
    isLoading = true;
    notifyListeners();
    final response = await ref
        .read(apiClientProvider)
        .get('${AppConstant.searchProductsUrl}?q=$searchKey');
    if (response.statusCode == 200) {
      _productList = response.data['products']
          .map<Products>((product) => Products.fromMap(product))
          .toList();
      isLoading = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  void productQuantity({
    required bool isIncress,
    required int productPrice,
  }) {
    if (isIncress) {
      quantity++;
    } else if (isIncress == false && quantity != 0) {
      quantity--;
    }
    totalProudctPrice = productPrice * quantity;
    notifyListeners();
  }
}

final productProvider = ChangeNotifierProvider((ref) => ProductProvider(ref));
