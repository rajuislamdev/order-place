import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:place_order/model/cart_product.dart';
import 'package:place_order/provider/product_provider.dart';
import 'package:place_order/routes.dart';
import 'package:place_order/view/base/Custom_dialog.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<CartProduct> cartProducts = ref.read(productProvider).cartProductList;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Cart Products'),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: cartProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      tileColor: Theme.of(context).hintColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      title: Text(
                        cartProducts[index].title.toString(),
                      ),
                      subtitle:
                          Text('Total Amount: ${cartProducts[index].price} TK'),
                      trailing: IconButton(
                        onPressed: () {
                          ref
                              .read(productProvider)
                              .deleteCarts(id: cartProducts[index].id);
                          showDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                              title:
                                  'API is working fine but add and delete not perform to the server.check flutter log',
                              buttonText: 'Okay',
                              imagePath: 'assets/done.png',
                              onTap: () {
                                Navigator.pushNamed(context, Routes.dashboard);
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 30,
                          color: Color.fromARGB(255, 135, 10, 10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
