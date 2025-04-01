import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/cart_item.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/cart_total.dart';
import 'package:pizzaprint_v4/interface/theme/theme.dart';
import 'package:pizzaprint_v4/interface/utils/model_adapter.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? _selectedLocation;
  String _selectedPaymentMethod = 'Cash on Delivery'; // Default payment method

  @override
  void initState() {
    super.initState();
    _selectedLocation = 'Home'; // Default location
  }

  void _printOrderDetails() {
    print("Order Details:");
    print("Location: $_selectedLocation");
    print("Payment Method: $_selectedPaymentMethod");

    final cartProvider = context.read<CartProvider>();
    for (var item in cartProvider.cartItems.values) {
      print("${item.food.name} (${item.size}) - Quantity: ${item.quantity} - \$${(ModelAdapter.getPriceForSize(item.food, item.size) * item.quantity).toStringAsFixed(2)}");
    }
    print("Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}");
  }

  void _navigateToPaymentScreen() {
    // Check if cart is empty
    final cartProvider = context.read<CartProvider>();
    if (cartProvider.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty!")),
      );
      return;
    }

    // Check if location and payment method are selected
    if (_selectedLocation == null || _selectedPaymentMethod.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select location and payment method")),
      );
      return;
    }

    // Print order details to the terminal
    _printOrderDetails();

    // Show "Order placed!" message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order placed!")),
    );

    // Here you would navigate to the payment screen
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(...)));
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList = cartProvider.cartItems.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        backgroundColor: PizzaColors.primary,
        foregroundColor: PizzaColors.white,
      ),
      body: cartItemsList.isEmpty
          ? _buildEmptyCart(context)
          : ListView.builder(
              itemCount: cartItemsList.length,
              itemBuilder: (context, index) {
                final item = cartItemsList[index];
                return CartItemWidget(
                  item: item,
                  removeFromCart: cartProvider.removeFromCart,
                );
              },
            ),
      bottomNavigationBar: _buildBottomNavigationBar(context, cartProvider),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text("Your cart is empty", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              backgroundColor: PizzaColors.primary,
            ),
            child: const Text("Browse Menu", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, CartProvider cartProvider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select Location:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ListTile(
                    title: Text(_selectedLocation ?? "Choose a Location"),
                    leading: const Icon(Icons.location_on),
                    onTap: () async {
                      // Show location selection dialog
                      final selectedLocation = await _selectLocation(context);
                      if (selectedLocation != null) {
                        setState(() {
                          _selectedLocation = selectedLocation;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text("Payment Method: $_selectedPaymentMethod"),
                    leading: const Icon(Icons.payment),
                    onTap: () async {
                      final selectedPaymentMethod = await _selectPaymentMethod(context);
                      if (selectedPaymentMethod != null) {
                        setState(() {
                          _selectedPaymentMethod = selectedPaymentMethod;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          CartTotalWidget(
            totalAmount: cartProvider.totalAmount,
            cartItems: cartProvider.cartItems.values.toList(),
            onCheckout: _navigateToPaymentScreen,
          ),
        ],
      ),
    );
  }

  Future<String?> _selectLocation(BuildContext context) async {
    // Display a bottom sheet to select location
    return await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context, 'Home');
              },
            ),
            ListTile(
              title: const Text('Office'),
              onTap: () {
                Navigator.pop(context, 'Office');
              },
            ),
            ListTile(
              title: const Text('Other'),
              onTap: () {
                Navigator.pop(context, 'Other');
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> _selectPaymentMethod(BuildContext context) async {
    // Display a bottom sheet to select payment method
    return await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Cash on Delivery'),
              onTap: () {
                Navigator.pop(context, 'Cash on Delivery');
              },
            ),
            ListTile(
              title: const Text('Credit/Debit Card'),
              onTap: () {
                Navigator.pop(context, 'Credit/Debit Card');
              },
            ),
            ListTile(
              title: const Text('PayPal'),
              onTap: () {
                Navigator.pop(context, 'PayPal');
              },
            ),
            ListTile(
              title: const Text('ABA'),
              onTap: () {
                Navigator.pop(context, 'ABA');
              },
            ),
          ],
        );
      },
    );
  }
}
