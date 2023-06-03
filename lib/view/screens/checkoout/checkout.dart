import 'package:flutter/material.dart';
import 'package:place_order/model/cart_product.dart';
import 'package:place_order/view/base/custom_button.dart';

class CheckoutScreen extends StatelessWidget {
  final CartProduct cartProduct;
  const CheckoutScreen({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
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
                                    text: ' Tk',
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
                        tralingText: 'TK'),
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
                        tralingText: 'Tk'),
                    const Spacer(),
                    CustomButton(
                      width: double.infinity,
                      onPressed: () {},
                      buttonText: 'Payment',
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
