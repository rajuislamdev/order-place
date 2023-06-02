import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/provider/cart_provider.dart';
import 'package:place_order/view/base/custom_appbar.dart';
import 'package:place_order/view/base/product_shimmer.dart';
import 'package:place_order/view/base/product_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(productProvider).getProducts();
    });
    super.initState();
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(searchController: searchController),
      body: GridView.builder(
        itemCount: ref.watch(productProvider).isLoading
            ? 10
            : ref.read(productProvider).productList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Set the number of items per row
          mainAxisSpacing: 1.5,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ref.read(productProvider).isLoading
              ? const ProductShimmerWidget()
              : ProductWidget(
                  product: ref.read(productProvider).productList[index]),
        ),
      ),
    );
  }
}
