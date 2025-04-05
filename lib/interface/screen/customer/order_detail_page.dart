import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../order_tracking_screen.dart';

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order ${order['orderNumber']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Number: ${order['orderNumber']}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 20),
            Text('Status: ${order['status']}'),
            Text('Total: \$${order['totalAmount']}'),
            Text('Delivery Fee: \$${order['deliveryFee']}'),
            Text('Tax: \$${order['tax']}'),
            Text('Discount: \$${order['discount']}'),
            Text('Payment Method: ${order['paymentMethod']}'),
            Text('Notes: ${order['notes'] ?? "None"}'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to the OrderTrackingScreen when the user wants to track the order
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderTrackingScreen(orderId: order['orderId']),
                  ),
                );
              },
              child: Text('Track Order'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
