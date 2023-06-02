import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;

  const CustomAppBar({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Place Order',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      toolbarHeight: 200,
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: IconButton(
            onPressed: () {},
            icon: Stack(
              clipBehavior: Clip.none,
              children: const [
                Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 30,
                ),
                Positioned(
                  top: -6,
                  right: -4,
                  child: CircleAvatar(
                    radius: 10,
                    child: Text(
                      '5',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   height: 50,
        //   decoration: BoxDecoration(
        //     color: const Color(0xFFe7edeb),
        //     borderRadius: BorderRadius.circular(8.0),
        //   ),
        //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //   child: TextFormField(
        //     controller: searchController,
        //     decoration: const InputDecoration(
        //       hintText: 'Search',
        //       border: InputBorder.none,
        //       suffixIcon: Icon(Icons.search),
        //     ),
        //   ),
        // ),
      ],
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFe7edeb),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        120,
      ); // Set the preferred height of the custom AppBar
}
