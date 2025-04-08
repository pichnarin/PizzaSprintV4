import 'package:flutter/material.dart';
import '../order_tracking_screen.dart';

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderItems = order['orderItems'] ?? [];
    final address = order['address'] ?? {};

    return Scaffold(
      appBar: AppBar(title: Text('Order ${order['orderNumber']}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info
            Text('Order Details', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            _infoRow('Order Number', order['orderNumber']),
            _infoRow('Status', order['status']),
            _infoRow('Total', '\$${order['totalAmount']}'),
            _infoRow('Delivery Fee', '\$${order['deliveryFee']}'),
            _infoRow('Tax', '\$${order['tax']}'),
            if (order['discount'] != 0.0)
              _infoRow('Discount', '\$${order['discount']}'),
            _infoRow('Payment Method', order['paymentMethod']),
            if (order['notes'] != 'N/A') _infoRow('Notes', order['notes']),
            const SizedBox(height: 20),

            // Address Info
            Text(
              'Delivery Address',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            _infoRow('Reference', address['reference']),
            _infoRow('City', address['city']),
            _infoRow('State', address['state']),
            _infoRow('ZIP', address['zip']),
            _infoRow('Latitude', address['latitude']),
            _infoRow('Longitude', address['longitude']),
            const SizedBox(height: 20),

            // Order Items
            if (orderItems.isNotEmpty) ...[
              Text(
                'Ordered Items',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ...orderItems.map<Widget>((item) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item['itemName']),
                  subtitle: Text('Quantity: ${item['quantity']}'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${item['price']}'),
                      Text('Subtotal: \$${item['subTotal']}'),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
            ],

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.map),
                  label: const Text('Track Order'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                OrderTrackingScreen(orderId: order['orderId']),
                      ),
                    );
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Custom reusable row for clean info display
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$title:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }
}
