// import 'package:flutter/material.dart';
//
// class PickupScreen extends StatelessWidget {
//   final Map<String, dynamic> order;
//
//   // Constructor to receive order data
//   const PickupScreen({Key? key, required this.order}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Pickup Screen")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Order Number: ${order['orderNumber']}",
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             const SizedBox(height: 20),
//             Text("Customer: ${order['customerName']}"),
//             Text("Pickup Location: ${order['address']['reference']}"),
//             Text("City: ${order['address']['city']}"),
//             Text("State: ${order['address']['state']}"),
//             Text("Zip: ${order['address']['zip']}"),
//             Text("Latitude: ${order['address']['latitude']}"),
//             Text("Longitude: ${order['address']['longitude']}"),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 // Action to start the delivery process, or any other logic
//                 Navigator.pop(context); // For example, to go back
//               },
//               child: const Text("Start Delivery"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
