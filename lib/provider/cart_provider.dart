import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/model/product.dart';
import 'package:place_order/util/app_constants.dart';
import 'package:place_order/utils/api_client.dart';

class ProductProvider extends ChangeNotifier {
  final Ref ref;

  ProductProvider(this.ref);
  bool isLoading = false;

  List<Products> _productList = [];
  List<Products> get productList => _productList;

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
}

final productProvider = ChangeNotifierProvider((ref) => ProductProvider(ref));
