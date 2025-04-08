import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:pizzaprint_v4/interface/utils/model_adapter.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final Function(String) removeFromCart;
  final Function(String, int) updateQuantity;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.removeFromCart,
    required this.updateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    // Use ModelAdapter to get the price for the selected size
    final itemPrice = ModelAdapter.getPriceForSize(item.food, item.size);
    final totalItemPrice = itemPrice * item.quantity;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Left Column with Image and Food Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image - Ensuring it stays within the card
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: item.food.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => const CircularProgressIndicator(),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(height: 8),
                // Food name under the image
                Text(
                  item.food.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Adjust the font size for better readability
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Price Display - below food name
                Text(
                  "\$${totalItemPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),

            // Right Column with Quantity
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Quantity display with increase and decrease buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (item.quantity > 1) {
                            updateQuantity(
                              "${item.food.id}_${item.size}",
                              item.quantity - 1,
                            );
                          } else {
                            removeFromCart("${item.food.id}_${item.size}");
                          }
                        },
                        color: Colors.orange,
                      ),
                      Text(
                        "${item.quantity}",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          updateQuantity(
                            "${item.food.id}_${item.size}",
                            item.quantity + 1,
                          );
                        },
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
