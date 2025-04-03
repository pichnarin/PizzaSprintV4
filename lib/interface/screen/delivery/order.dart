import 'package:flutter/material.dart';

import '../../../domain/service/order_service.dart';
import 'accepted_order_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<Map<String, dynamic>>> orders;

  @override
  void initState() {
    super.initState();
    orders = OrderService().fetchAssigningOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Order Details'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No orders found"));
          }

          List<Map<String, dynamic>> ordersData = snapshot.data!;

          return ListView.builder(
            itemCount: ordersData.length,
            itemBuilder: (context, index) {
              var order = ordersData[index];
              var orderItems = order['orderItems'] as List;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Customer Info Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/user1.png',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order['customerName'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Text(
                                    order['paymentMethod'],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${order['totalAmount']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${order['distance'] ?? 'N/A'} km",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Pickup Location
                    const Text('PICK UP', style: TextStyle(color: Colors.grey)),
                    Text(
                      order['pickupLocation'] ?? 'Unknown',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Divider(),

                    // Drop Off Location
                    const Text(
                      'DROP OFF',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "${order['customerAddress']['street']}, ${order['customerAddress']['city']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),

                    // Noted Section
                    const Text('NOTED', style: TextStyle(color: Colors.grey)),
                    Text(order['note'] ?? "No special instructions."),
                    const SizedBox(height: 16),
                    const Divider(),

                    // Payment Section
                    const Text('PAYMENT', style: TextStyle(color: Colors.grey)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order['paymentMethod']),
                        Text("\$${order['totalAmount']}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Fee'),
                        Text("\$${order['deliveryFee']}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Paid Amount',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$${order['totalPaid']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          icon: Icons.phone,
                          text: 'Call',
                          backgroundColor: const Color(0xFFB0E0C2),
                          textColor: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        _buildActionButton(
                          icon: Icons.message,
                          text: 'Message',
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        _buildActionButton(
                          icon: Icons.cancel,
                          text: 'Cancel',
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Divider(),

                    // Order Items Section
                    const Text(
                      "Order Items",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...orderItems.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${item['itemName']} (x${item['quantity']})"),
                            Text("\$${item['subTotal']}"),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 24),
                    const Divider(),

                    Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () async {
                          print("Order object: $order");

                          // Proceed if the order ID exists
                          String orderId = order['orderId']?.toString() ?? '';
                          if (orderId.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid order ID."),
                              ),
                            );
                            return;
                          }

                          bool isAccepted = await OrderService().acceptOrder(
                            orderId,
                          );

                          if (isAccepted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Order accepted successfully!"),
                              ),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => PickupScreen(order: order),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Failed to accept the order. Try again.",
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.amber,
                          child: const Text(
                            'GO TO PICK UP',
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Reusable Action Button
Widget _buildActionButton({
  required IconData icon,
  required String text,
  required Color backgroundColor,
  required Color textColor,
}) {
  return Expanded(
    child: ElevatedButton(
      onPressed: () {
        // Handle button press
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 28),
          const SizedBox(height: 5),
          Text(text, style: TextStyle(color: textColor)),
        ],
      ),
    ),
  );
}
