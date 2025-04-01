import 'package:flutter/material.dart';

class RideHistoryCard extends StatelessWidget {
  final String name;
  final String image;
  final String payment;
  final String price;
  final String distance;
  final String pickup;
  final String dropoff;

  const RideHistoryCard({
    Key? key,
    required this.name,
    required this.image,
    required this.payment,
    required this.price,
    required this.distance,
    required this.pickup,
    required this.dropoff,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200, 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundImage: AssetImage(image)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  _paymentBadge(payment)
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(distance, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),
          _locationRow('PICK UP', pickup),
          const SizedBox(height: 5),
          const Divider(height: 20),
          const SizedBox(height: 5),
          _locationRow('DROP OFF', dropoff),
          
                    // User & Price
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Row(
      //           children: [
      //             CircleAvatar(backgroundImage: AssetImage(image)),
      //             const SizedBox(width: 10),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      //                 _paymentBadge(payment),
      //               ],
      //             ),
      //           ],
      //         ),
      //         Column(
      //           children: [
      //             Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
      //             Text(distance, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      //           ],
      //         ),
      //       ],
      //     ),
      //     // Pickup & Drop-off
      //     _locationRow('PICK UP', pickup),
      //     const SizedBox(height: 5),
      //     const Divider(height: 20),
      //     const SizedBox(height: 5),
      //     _locationRow('DROP OFF', dropoff),
         ],
      ),
    );
  }

  Widget _locationRow(String label, String location) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
        Text(location, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _paymentBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.yellow.shade700,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
