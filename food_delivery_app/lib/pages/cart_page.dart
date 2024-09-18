import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart';
import 'package:food_delivery_app/models/resturant.dart';
import 'package:food_delivery_app/pages/payment_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Resturant>(
      builder: (context, resturant, child) {
        //cart
        final userCart = resturant.cart;

        //scaffold UI
        return Scaffold(
          appBar: AppBar(
            title: const Text("cart"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              //clear all cart
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title:
                          const Text('Are you sure you want to clear the cart'),
                      actions: [
                        // cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        // yes button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            resturant.clearCart();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              //list of cart
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty
                        ? const Expanded(
                            child: Center(
                              child: Text('Cart is empty'),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: userCart.length,
                              itemBuilder: (context, index) {
                                final cartItem = userCart[index];
                                ListTile(
                                  title: Text(cartItem.food.name),
                                );
                                return MyCarTile(cartItem: cartItem);
                              },
                            ),
                          ),
                  ],
                ),
              ),
              //button to pay
              MyButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const PaymentPage(),
                    ),
                  );
                },
                text: 'Go to Checkout',
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        );
      },
    );
  }
}
