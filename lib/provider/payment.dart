import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/util/app_constants.dart';
import 'package:place_order/utils/api_client.dart';

class PaymentProvider extends ChangeNotifier {
  final Ref ref;
  PaymentProvider(this.ref);
  final String paymentSecret =
      'sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPlq00wmjWwZYA';
  Future<String?> createPaymentIntent(
      {required int amount, required String currency}) async {
    try {
      final response = await ref
          .read(apiClientProvider)
          .post(AppConstant.paymentUrl, headers: {
        'Authorization': 'Bearer $paymentSecret',
        'Content-Type': 'application/x-www-form-urlencoded'
      }, data: {
        'amount': amount,
        'currency': currency,
      });
      final String clientSecret = response.data['client_secret'];
      return clientSecret;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

final paymentProvider = ChangeNotifierProvider((ref) => PaymentProvider(ref));
