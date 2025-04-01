// import 'package:flutter/material.dart';
// import '../../../../domain/providers/cart_provider.dart';

// class PaymentScreen extends StatefulWidget {
//   final CartProvider cartProvider;
//   final String selectedLocation; // Add selectedLocation as a parameter
//   final String selectedPaymentMethod; // Add selectedPaymentMethod as a parameter

//   const PaymentScreen({
//     super.key,
//     required this.cartProvider,
//     required this.selectedLocation,
//     required this.selectedPaymentMethod,
//   });

//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   late List<CartItem> cartItems;
//   late String _selectedPaymentMethod;
//   late String _selectedLocation;

//   // List of payment methods
//   final List<String> _paymentMethods = [
//     'Cash on Delivery',
//     'Credit/Debit Card (Stripe)',
//     'PayPal',
//     'ABA',
//     'ACELEDA'
//   ];

//   @override
//   void initState() {
//     super.initState();
//     cartItems = widget.cartProvider.cartItems.values.toList();
//     _selectedPaymentMethod = widget.selectedPaymentMethod; // Use widget to access the selectedPaymentMethod
//     _selectedLocation = widget.selectedLocation; // Use widget to access the selectedLocation
//   }

//   // Function to show the bottom sheet for selecting the payment method
//   Future<void> _selectPaymentMethod() async {
//     final selectedMethod = await showModalBottomSheet<String>(
//       context: context,
//       builder: (context) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: _paymentMethods.map((String method) {
//             return ListTile(
//               title: Text(method),
//               onTap: () {
//                 Navigator.pop(context, method); // Return the selected method
//               },
//             );
//           }).toList(),
//         );
//       },
//     );

//     if (selectedMethod != null) {
//       setState(() {
//         _selectedPaymentMethod = selectedMethod; // Update the selected payment method
//       });
//     }
//   }

//   // Confirm payment and clear the cart
//   void _confirmPayment() {
//     // Clear cart and show success message only in CartScreen, not here.
//     widget.cartProvider.clearCart();

//     // Navigate back to the CartScreen
//     Navigator.pop(context); // Go back to Cart screen
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Payment Summary")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Order Details:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text("Location: $_selectedLocation"), // Display selected location
//             const SizedBox(height: 8),
//             const Text(
//               "Payment Method:",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             // Display the selected payment method and open bottom sheet on tap
//             GestureDetector(
//               onTap: _selectPaymentMethod, // Open the payment method bottom sheet
//               child: Row(
//                 children: [
//                   Icon(Icons.payment),
//                   SizedBox(width: 8),
//                   Text(_selectedPaymentMethod), // Display selected payment method
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Display cart items
//             for (var item in cartItems)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Text(
//                   "${item.product.name} (${item.size}) - Quantity: ${item.quantity} - \$${(item.product.prices[item.size]! * item.quantity).toStringAsFixed(2)}",
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             const SizedBox(height: 8),
//             Text(
//               "Total: \$${widget.cartProvider.totalAmount.toStringAsFixed(2)}",
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const Spacer(),
//             ElevatedButton(
//               onPressed: _confirmPayment,
//               style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
//               child: const Text("Confirm Payment"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
