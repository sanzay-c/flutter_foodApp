import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/cart_page.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  final Widget child;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        // cart button
        IconButton(
          onPressed: () {
            //go to cart page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const 
                CartPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.shopping_cart_outlined,
          ),
        ),
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Sunset Diner"),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(
            bottom: 50.0,
          ),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        expandedTitleScale: 1,
      ),
    );
  }
}
