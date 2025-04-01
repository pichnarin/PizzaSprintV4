
import 'package:flutter/material.dart';
import '../../component/driver_widget/delivery_order_card.dart';

class ActiveOrder extends StatefulWidget {

  @override
  State<ActiveOrder> createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Order', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.amber,
            width: double.infinity,
            child: const Text(
              'You have 5 new requests.',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                OrderCard(
                  avatar: 'assets/images/user1.png',
                  name: 'Steve Brown',
                  paymentMethod: 'ABA',
                  price: '1.75',
                  distance: '5.1',
                  pickupLocation: 'Street360',
                  dropoffLocation: '234 ToulKork St, PhnomPenh',
                  onAction: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => OrderDetail(id: id, name: name, quantity: quantity, price: price, sub_total: sub_total, foodId: foodId, orderId: orderId),
                    //   )
                    // );
                  },
                  actionText: 'Accept', 
                ),
                OrderCard(
                  avatar: 'assets/images/user2.png',
                  name: 'Stella Daily',
                  paymentMethod: 'ACLEDA Discount',
                  price: '1.50',
                  distance: '3.2',
                  pickupLocation: 'Street360',
                  dropoffLocation: '234 ToulKork St, PhnomPenh',
                  onAction: () {
                    // Handle Accept action
                  },
                  actionText: 'Accept',
                ),
                OrderCard(
                  avatar: 'assets/images/user3.png',
                  name: 'Sarah Mata',
                  paymentMethod: 'CASH',
                  price: '1.60',
                  distance: '4.7',
                  pickupLocation: 'Street360',
                  dropoffLocation: '234 ToulKork St, PhnomPenh',
                  onAction: () {
                    // Handle Accept action
                  },
                  actionText: 'Accept',
                ),
              ],
            ),
          ),
        ],
      ),
      
      
    );
  }
}