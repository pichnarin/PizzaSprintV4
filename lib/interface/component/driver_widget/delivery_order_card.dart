import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String name;
  final String avatar;
  final String paymentMethod;
  final String price;
  final String distance;
  final String pickupLocation;
  final String dropoffLocation;
  final VoidCallback? onAccept;
  final VoidCallback? onIgnore;
  final VoidCallback? onAction;
  final String? actionText;

  const OrderCard({
    Key? key,
    required this.name,
    required this.price,
    required this.distance,
    required this.pickupLocation,
    required this.dropoffLocation,
    this.onAccept,
    this.onIgnore, 
    this.onAction,
    this.actionText,
    required this .avatar, 
    required this.paymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('$avatar'), 
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(18)),
                            child: Text("$paymentMethod", style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("\$$price", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("$distance km", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text("PICK UP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              Text(pickupLocation),
              SizedBox(height: 5),
              Divider(),
              Text("DROP OFF", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              Text(dropoffLocation),
              SizedBox(height: 30),
              if (onAccept != null || onIgnore != null || onAction != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (onIgnore != null)
                    TextButton(
                      onPressed: onIgnore,
                      child: const Text("Ignore"),
                    ),
                  if (onAccept != null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                      onPressed: onAccept,
                      child: const Text("Accept"),
                    ),
                  if (onAction != null)
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber, 
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), 
                          ),
                        ),
                        onPressed: onAction,
                        child: Text(actionText ?? "Action"),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
  
  }
}
