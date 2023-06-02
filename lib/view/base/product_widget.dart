import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/model/product.dart';

class ProductWidget extends ConsumerWidget {
  final Products product;
  const ProductWidget({
    super.key,
    required this.product,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: MediaQuery.of(context).size.width / 1.2,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).highlightColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 5,
            )
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Product Image
                Container(
                  height: MediaQuery.of(context).size.width / 2.7,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/place-holder.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width / 2.45,
                      image: product.images!.first,
                      imageErrorBuilder: (c, o, s) => Image.asset(
                          'assets/dress.jpg',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width / 2.45),
                    ),
                  ),
                ),

                // Product Details
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 5, left: 5, right: 5),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.title.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${product.price} Tk',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
