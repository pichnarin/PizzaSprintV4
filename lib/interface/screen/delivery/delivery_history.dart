import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';
import '../../component/driver_widget/delivery_date_selector.dart';
import '../../component/driver_widget/delivery_order_card.dart';
import '../../component/driver_widget/delivery_order_summary_card.dart';


class DeliveryHistory extends StatefulWidget {
  const DeliveryHistory({super.key});

  @override
  _DeliveryHistoryState createState() => _DeliveryHistoryState();
}

class _DeliveryHistoryState extends State<DeliveryHistory> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:
        Column(
          children: [
            DateSelector(),
        
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SummaryCard(
                  icon: Icons.motorcycle,
                  title: 'Total Distance',
                  value: '22km',
                  color: AppPallete.card1,
                ),
                SizedBox(width: 30,),
                SummaryCard(
                  icon: Icons.attach_money,
                  title: 'Total Earned',
                  value: '\$10.50',
                  color: AppPallete.card2,
                ),
              ],
            ),
            const SizedBox(height: 30),
            
            // Ride History List
            Expanded(child: _buildRideHistoryList()),
        
          ],
        ),
      
    );
    
  }

  

  /// Ride History List
  Widget _buildRideHistoryList() {
    final rideHistory = [
      {
        'name': 'Steve Brown',
        'price': '1.75',
        'distance': '5.1',
        'pickupLocation': 'Street360',
        'dropoffLocation': '234 ToulKork St, PhnomPenh',
        'avatar': 'assets/images/user1.png',
        'paymentMethod': 'ABA',
      },
      {
        'name': 'Stella Daily',
        'price': '1.50',
        'distance': '3.2',
        'pickupLocation': 'Street360',
        'dropoffLocation': '234 ToulKork St, PhnomPenh',
        'avatar': 'assets/images/user2.png',
        'paymentMethod': 'ACLEDA',
      },
      {
        'name': 'Sarah Mata',
        'price': '1.60',
        'distance': '4.7',
        'pickupLocation': 'Street360',
        'dropoffLocation': '234 ToulKork St, PhnomPenh',
        'avatar': 'assets/images/user3.png',
        'paymentMethod': 'CASH',
      },
    ];

    return ListView.builder(
      itemCount: rideHistory.length,
      itemBuilder: (context, index) {
        final ride = rideHistory[index];
        return OrderCard(
          name: ride['name']!,
          avatar: ride['avatar']!,
          paymentMethod: ride['paymentMethod']!,
          price: ride['price']!,
          distance: ride['distance']!,
          pickupLocation: ride['pickupLocation']!,
          dropoffLocation: ride['dropoffLocation']!,
        );
      },
    );
}
}