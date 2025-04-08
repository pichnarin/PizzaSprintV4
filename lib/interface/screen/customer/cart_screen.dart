import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pizzaprint_v4/domain/provider/cart_provider.dart';
import 'package:pizzaprint_v4/domain/service/order_service.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/cart_item.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/cart_total.dart';
import 'package:pizzaprint_v4/interface/theme/theme.dart';
import '../../../domain/provider/address_provider.dart';
import 'addresses_list_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _selectedPaymentMethod = 'Cash on Delivery';
  final OrderService orderService = OrderService();

  void _placeOrder() async {
    final cartProvider = context.read<CartProvider>();
    final addressProvider = context.read<AddressProvider>();

    if (cartProvider.cartItems.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Your cart is empty!")));
      return;
    }

    if (addressProvider.address.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an address")));
      return;
    }

    final orderData = {
      "address_id": addressProvider.address.keys.first,
      "payment_method": _selectedPaymentMethod,
      "food": cartProvider.getOrderData(),
    };

    await orderService.placeOrder(orderData);

    cartProvider.clearCart();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Order placed successfully!")));
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);
    final cartItemsList = cartProvider.cartItems.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        backgroundColor: PizzaColors.primary,
        foregroundColor: PizzaColors.white,
      ),
      body:
          cartItemsList.isEmpty
              ? const Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
              : ListView.builder(
                itemCount: cartItemsList.length,
                itemBuilder: (context, index) {
                  final item = cartItemsList[index];
                  return CartItemWidget(
                    item: item,
                    removeFromCart: cartProvider.removeFromCart,
                    updateQuantity: (cartItemId, quantity) {
                      if (quantity > 0) {
                        cartProvider.updateQuantity(item, quantity);
                      } else {
                        cartProvider.removeFromCart(cartItemId);
                      }
                    },
                  );
                },
              ),
      bottomNavigationBar: _buildBottomNavigationBar(
        context,
        cartProvider,
        addressProvider,
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    CartProvider cartProvider,
    AddressProvider addressProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Address:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    title: Text(
                      addressProvider.address.isNotEmpty
                          ? addressProvider.address.values.first
                          : "Choose an Address",
                    ),
                    leading: const Icon(Icons.location_on),
                    onTap: () async {
                      final selectedAddressId = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressListScreen(),
                        ),
                      );
                      if (selectedAddressId != null) {
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: Text("Payment Method: $_selectedPaymentMethod"),
                    leading: const Icon(Icons.payment),
                    onTap: () async {
                      final selectedPaymentMethod = await _selectPaymentMethod(
                        context,
                      );
                      if (selectedPaymentMethod != null) {
                        setState(
                          () => _selectedPaymentMethod = selectedPaymentMethod,
                        );
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
            onCheckout: _placeOrder,
          ),
        ],
      ),
    );
  }

  Future<String?> _selectPaymentMethod(BuildContext context) async {
    return await showModalBottomSheet<String>(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Cash on Delivery'),
                onTap: () => Navigator.pop(context, 'Cash on Delivery'),
              ),
              ListTile(
                title: const Text('Credit/Debit Card'),
                onTap: () => Navigator.pop(context, 'Credit/Debit Card'),
              ),
              ListTile(
                title: const Text('PayPal'),
                onTap: () => Navigator.pop(context, 'PayPal'),
              ),
              ListTile(
                title: const Text('ABA'),
                onTap: () => Navigator.pop(context, 'ABA'),
              ),
            ],
          ),
    );
  }
}
