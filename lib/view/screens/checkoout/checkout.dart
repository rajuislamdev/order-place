// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:place_order/model/cart_product.dart';
import 'package:place_order/provider/payment.dart';
import 'package:place_order/routes.dart';
import 'package:place_order/view/base/Custom_dialog.dart';
import 'package:place_order/view/base/custom_button.dart';

class CheckoutScreen extends ConsumerWidget {
  final CartProduct cartProduct;
  const CheckoutScreen({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.purple,
                              border: Border.all(
                                  color: Colors.purple.shade200, width: 2)),
                          child: const Center(
                            child: Text(
                              'Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(width: 10),
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                cartProduct.title.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Price: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: cartProduct.price.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' \$',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Column(
                  children: [
                    rowTile(
                        title: 'Product Price:',
                        value: cartProduct.price.toDouble(),
                        tralingText: '\$'),
                    const SizedBox(height: 10),
                    rowTileQuantity(
                        title: 'Quantity:', value: cartProduct.quantity),
                    const SizedBox(height: 10),
                    rowTile(
                        title: 'Discount:',
                        value: cartProduct.discountPercentage,
                        tralingText: '%'),
                    const SizedBox(height: 10),
                    rowTile(
                        title: 'Total Price:',
                        value: cartProduct.discountedPrice.toDouble(),
                        tralingText: '\$'),
                    const Spacer(),
                    ref.watch(paymentProvider).isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            width: double.infinity,
                            onPressed: () {
                              payment(
                                  ref: ref,
                                  amount: cartProduct.discountedPrice,
                                  currency: 'USD',
                                  context: context);
                            },
                            buttonText: 'Checkout',
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> payment({
    required WidgetRef ref,
    required int amount,
    required String currency,
    required BuildContext context,
  }) async {
    try {
      final String? clientSecretKey = await ref
          .read(paymentProvider)
          .createPaymentIntent(amount: amount, currency: currency);
      print(clientSecretKey);

      final googlePay = PaymentSheetGooglePay(
          merchantCountryCode: "USA", currencyCode: currency, testEnv: true);

      // Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecretKey,
          style: ThemeMode.light,
          merchantDisplayName: 'Place',
          googlePay: googlePay,
        ),
      );
      // display pament sheet
      displayPaymentSheet(context);
    } catch (error) {
      print(error);
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => CustomDialog(
            title: 'Payment successfull',
            buttonText: 'Okay',
            imagePath: 'assets/done.png',
            onTap: () {
              Navigator.pushNamed(context, Routes.dashboard);
            },
          ),
        );
      });
    } catch (e) {
      print('$e');
    }
  }

  Widget rowTile(
      {required String title,
      required double value,
      required String tralingText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '$value $tralingText',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }

  Widget rowTileQuantity({
    required String title,
    required int value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
