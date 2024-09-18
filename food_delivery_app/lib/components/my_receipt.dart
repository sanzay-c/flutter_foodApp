import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/resturant.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Thank you for order!'),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(25),
              child: Consumer<Resturant>(
                builder: (context, resturant, child) => Text(
                  resturant.displayCartReceipt(),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text('Estimated delivery time is: 4:10 PM'),
          ],
        ),
      ),
    );
  }
}
