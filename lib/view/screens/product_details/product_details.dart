// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:place_order/model/product.dart';
import 'package:place_order/view/base/custom_button.dart';
import 'package:place_order/view/screens/product_details/widget/bottom_cart_view.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products products;

  const ProductDetailsScreen({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Product Image
                    SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: PageView.builder(
                          padEnds: false,
                          controller: controller,
                          itemCount: widget.products.images!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: 'assets/placeholder.png',
                                height: MediaQuery.of(context).size.width,
                                width: MediaQuery.of(context).size.width,
                                image: widget.products.images![index],
                                imageErrorBuilder: (c, o, s) => Image.asset(
                                  'assets/placeholder.png',
                                  height: MediaQuery.of(context).size.width,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          onPageChanged: (index) {
                            setImageSliderSelectedIndex(index);
                          },
                        )),

                    // Product Details
                  ],
                ),

                // Previous Image Button
                imageSliderIndex == 0
                    ? const SizedBox()
                    : const Positioned(
                        top: 140,
                        left: 10,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.purple,
                        ),
                      ),

                // Next Image Button
                imageSliderIndex == widget.products.images!.length - 1
                    ? const SizedBox()
                    : const Positioned(
                        top: 140,
                        right: 10,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.purple,
                        ),
                      ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.products.title.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.products.price.toString()} TK',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.products.description.toString(),
                    style: const TextStyle(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 45,
        child: CustomButton(
          width: double.infinity,
          radius: 0,
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              context: context,
              builder: (context) => CustomBottomSheet(product: widget.products),
            );
          },
          buttonText: 'Add To Cart',
        ),
      ),
    );
  }

  int imageSliderIndex = 0;

  void setImageSliderSelectedIndex(int selectedIndex) {
    setState(() {
      imageSliderIndex = selectedIndex;
    });
  }
}
