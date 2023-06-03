import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductShimmerWidget extends StatelessWidget {
  const ProductShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
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
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width / 2.45,
                        image: 'assets/placeholder.png',
                        imageErrorBuilder: (c, o, s) => Image.asset(
                          'assets/placeholder.png',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width / 2.45,
                        ),
                      ),
                    ),
                  ),

                  // Product Details
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 5,
                      left: 5,
                      right: 5,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Product Name TK',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '4534',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
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
      ),
    );
  }
}
