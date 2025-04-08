import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Food food;

  const ProductCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final String size = "Medium";
    final int quantity = 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Reduced border radius
          ),
          color: Colors.white,
          elevation: 3, // Reduced elevation
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10), // Reduced border radius
                  ),
                  child: CachedNetworkImage(
                    imageUrl: food.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Image.asset('assets/images/restaurant.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0), // Reduced padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Food Name
                    Text(
                      food.name,
                      style: const TextStyle(
                        fontSize: 14, // Reduced font size
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    // Price and Add Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price Container
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ), // Reduced padding
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Reduced border radius
                          ),
                          child: Text(
                            '\$${food.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12, // Reduced font size
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Add to Cart Button
                        InkWell(
                          onTap: () {
                            bool itemExists = cart.cartItems.values.any(
                              (item) => item.food.id == food.id,
                            );

                            if (itemExists) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${food.name} is already in the cart!',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } else {
                              cart.addToCart(food, size, quantity);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${food.name} added to cart!'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          splashColor: Colors.orange.withOpacity(0.3),
                          highlightColor: Colors.orange.withOpacity(0.2),
                          child: Container(
                            padding: const EdgeInsets.all(8), // Reduced padding
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.shade400,
                                  Colors.orange.shade700,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20, // Reduced icon size
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
