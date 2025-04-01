import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';

class CartTotalWidget extends StatelessWidget {
  final double totalAmount;
  final List<CartItem> cartItems;
  final VoidCallback onCheckout;

  const CartTotalWidget({
    super.key,
    required this.totalAmount,
    required this.cartItems,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Added rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Displaying the total price
            Text(
              "Total: \$${totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Replacing the ElevatedButton with PizzaButton
           ElevatedButton(
              onPressed: onCheckout, // This will handle the checkout logic
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Orange button color
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
