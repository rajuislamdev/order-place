import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/model/order.dart';
import 'package:place_order/model/product.dart';
import 'package:place_order/provider/auth_provider.dart';
import 'package:place_order/provider/product_provider.dart';
import 'package:place_order/routes.dart';
import 'package:place_order/view/base/Custom_dialog.dart';
import 'package:place_order/view/base/custom_button.dart';
import 'package:place_order/view/screens/product_details/widget/quantity_button.dart';

class CustomBottomSheet extends ConsumerWidget {
  final Products product;
  const CustomBottomSheet({Key? key, required this.product}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(authProvider).getToken();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.purple,
                    border:
                        Border.all(color: Colors.purple.shade200, width: 2)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 2.45,
                    image: product.images!.first,
                    imageErrorBuilder: (c, o, s) => Image.asset(
                        'assets/placeholder.png',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width / 2.45),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        product.title.toString(),
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
                            text: product.price.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
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
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Total Price: ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: ref
                                .watch(productProvider)
                                .totalProudctPrice
                                .toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const TextSpan(
                            text: ' TK',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
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
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QuantityButton(
                isIncrement: false,
                onPressed: () {
                  ref.read(productProvider).productQuantity(
                        isIncress: false,
                        productPrice: product.price ?? 0,
                      );
                },
              ),
              Text(
                ref.watch(productProvider).quantity.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              QuantityButton(
                isIncrement: true,
                onPressed: () {
                  ref.read(productProvider).productQuantity(
                        isIncress: true,
                        productPrice: product.price ?? 0,
                      );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          ref.watch(productProvider).isLoading
              ? const CircularProgressIndicator()
              : CustomButton(
                  onPressed: () async {
                    print('object');
                    final cartProduct = ProductData(
                        id: product.id,
                        quantity: ref.read(productProvider).quantity);
                    final orderData = OrderData(
                      // I have a uid but the API expect own authentication token number
                      // But i am login with firebase there haven't auth token that is expect API provider
                      // Website link: https://dummyjson.com/
                      userId: 1,
                      products: [cartProduct],
                    );
                    if (ref.read(productProvider).quantity != 0) {
                      bool isSuccess =
                          await ref.read(productProvider).addToCartProduct(
                                orderData: orderData,
                                context: context,
                              );
                      if (isSuccess) {
                        ref.read(productProvider).quantity = 0;
                        ref.read(productProvider).totalProudctPrice = 0;
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => CustomDialog(
                            title: 'The product is successfully added!',
                            buttonText: 'Okay',
                            imagePath: 'assets/done.png',
                            onTap: () async {
                              ref
                                  .read(productProvider)
                                  .getCartProducts(userId: 1);
                              Navigator.pushNamed(context, Routes.dashboard);
                            },
                          ),
                        );
                      }
                    }
                  },
                  buttonText: 'Add To Cart')
        ],
      ),
    );
  }
}
