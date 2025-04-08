import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class SizeSelectionScreen extends StatefulWidget {
  final Food food;

  const SizeSelectionScreen({super.key, required this.food});

  @override
  State<SizeSelectionScreen> createState() => _SizeSelectionScreenState();
}

class _SizeSelectionScreenState extends State<SizeSelectionScreen> {
  String _selectedSize = 'S';
  int _selectedQuantity = 1;

  final Map<String, dynamic> sizeDetails = {
    'S': {'label': 'Small', 'price': 0.0},
    'M': {'label': 'Medium', 'price': 2.0},
    'L': {'label': 'Large', 'price': 4.0},
  };

  @override
  Widget build(BuildContext context) {
    final basePrice = widget.food.price;
    final selectedSizePrice = sizeDetails[_selectedSize]!['price'] as double;
    final totalPrice = (basePrice + selectedSizePrice) * _selectedQuantity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.orange, // Changed to orange
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cartScreen');
                    },
                  ),
                  if (cartProvider.cartItemCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${cartProvider.cartItemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(widget.food.image, height: 180, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.food.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Size:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            Row(
                              children: sizeDetails.keys.map((size) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: ChoiceChip(
                                    label: Text(sizeDetails[size]!['label']),
                                    selected: _selectedSize == size,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _selectedSize = size;
                                      });
                                    },
                                    selectedColor: Colors.orange, // Changed to orange
                                    labelStyle: TextStyle(
                                      color: _selectedSize == size ? Colors.white : Colors.orange, // Changed to orange
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Quantity:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      if (_selectedQuantity > 1) {
                                        _selectedQuantity--;
                                      }
                                    });
                                  },
                                  color: Colors.orange, // Changed to orange
                                ),
                                Text('$_selectedQuantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      _selectedQuantity++;
                                    });
                                  },
                                  color: Colors.orange, // Changed to orange
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange, // Changed to orange
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total:", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('\$${totalPrice.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false).addToCart(
                          widget.food,
                          _selectedSize,
                          _selectedQuantity,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added ${widget.food.name} ($_selectedSize) to cart")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.orange, // Changed to orange
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("Add to cart", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
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
