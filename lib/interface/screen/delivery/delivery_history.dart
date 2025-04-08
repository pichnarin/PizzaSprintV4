import 'package:flutter/material.dart';
import '../../component/driver_widget/delivery_date_selector.dart';
import '../../../domain/service/order_service.dart';

class DeliveryHistory extends StatefulWidget {
  const DeliveryHistory({super.key});

  @override
  _DeliveryHistoryState createState() => _DeliveryHistoryState();
}

class _DeliveryHistoryState extends State<DeliveryHistory> {
  List<Map<String, dynamic>> rideHistory = [];
  List<Map<String, dynamic>> filteredHistory = [];

  bool isLoading = true;
  String selectedFilter = 'delivering'; // default filter

  @override
  void initState() {
    super.initState();
    _fetchOrderHistory(); // Fetch the order history initially
  }

  Future<void> _fetchOrderHistory() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      final response = selectedFilter == 'delivering'
          ? await OrderService().fetchDeliveryOrderHistory() // Fetch delivering orders
          : await OrderService().fetchOrderHistory(); // Fetch completed orders

      print('Order history response: $response'); // Debug: Print the response

      if (response != null) {
        setState(() {
          rideHistory = response; // Assuming response is a list
          _applyFilter(); // Apply filter after fetching the orders
        });
      }
    } catch (e) {
      print('Error fetching order history: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  void _applyFilter() {
    setState(() {
      filteredHistory = rideHistory.where((order) {
        return order['status'] == selectedFilter; // Filter by status
      }).toList();
    });
  }

  void _onFilterChanged(String filter) {
    setState(() {
      selectedFilter = filter;
      _fetchOrderHistory(); // Fetch new history based on filter
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          DateSelector(),

          const SizedBox(height: 10),
          // Filter Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(10),
              isSelected: [
                selectedFilter == 'delivering',
                selectedFilter == 'completed',
              ],
              onPressed: (index) {
                if (index == 0) {
                  _onFilterChanged('delivering');
                } else {
                  _onFilterChanged('completed');
                }
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Delivering'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Completed'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Order List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredHistory.isEmpty
                ? const Center(child: Text('No delivery history found.'))
                : _buildRideHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRideHistoryList() {
    return ListView.builder(
      itemCount: filteredHistory.length,
      itemBuilder: (context, index) {
        final ride = filteredHistory[index];

        final customerName = ride['customerName'] ?? 'Unknown';
        final customerAvatar = ride['customerAvatar'] ?? '';
        final pickupLocation = ride['address']?['reference'] ?? 'N/A';
        final dropoffLocation = ride['address']?['placeName'] ?? 'N/A';
        final orderItem = ride['orderItems']?[0] ?? {};
        final itemName = orderItem['itemName'] ?? 'Unknown';
        final itemPrice = orderItem['price'] ?? 0.0;

        return OrderCard(
          name: customerName,
          avatar: customerAvatar,
          paymentMethod: ride['paymentMethod'] ?? 'N/A',
          price: (ride['totalAmount'] != null)
              ? double.tryParse(ride['totalAmount']!.toString())?.toStringAsFixed(2) ?? '0.00'
              : '0.00',
          distance: 'N/A',
          pickupLocation: pickupLocation,
          dropoffLocation: dropoffLocation,
          orderId: ride['orderId']?.toString() ?? '0',
          status: ride['status'],
          onCompleted: _fetchOrderHistory, // Refresh history after completing
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final String name;
  final String avatar;
  final String paymentMethod;
  final String price;
  final String distance;
  final String pickupLocation;
  final String dropoffLocation;
  final String orderId;
  final String status;
  final VoidCallback onCompleted;

  const OrderCard({
    required this.name,
    required this.avatar,
    required this.paymentMethod,
    required this.price,
    required this.distance,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.orderId,
    required this.status,
    required this.onCompleted,
  });

  bool _isAvailable(String? value) {
    return value != null && value.trim().isNotEmpty && value.trim().toLowerCase() != 'n/a';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: avatar.isNotEmpty
                      ? NetworkImage(avatar)
                      : const AssetImage('assets/images/user1.png') as ImageProvider,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (_isAvailable(paymentMethod))
                        Text(paymentMethod, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                if (status == 'delivering')
                  ElevatedButton(
                    onPressed: () async {
                      // Convert orderId to an integer
                      final orderIdInt = int.tryParse(orderId);

                      if (orderIdInt != null) {
                        final success = await OrderService().completeOrder(orderIdInt);
                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order marked as completed!')),
                          );
                          onCompleted();  // Refresh history after completing
                        }
                      } else {
                        // Handle the error if orderId cannot be converted to an integer
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid order ID')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: const Text('Complete'),
                  ),

              ],
            ),
            const SizedBox(height: 8),
            if (_isAvailable(price)) Text('Price: \$$price'),
            if (_isAvailable(distance)) Text('Distance: $distance km'),
            if (_isAvailable(pickupLocation)) Text('Pickup: $pickupLocation'),
            if (_isAvailable(dropoffLocation)) Text('Dropoff: $dropoffLocation'),
          ],
        ),
      ),
    );
  }
}
