import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  final String orderId;
  const OrderDetail({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('$orderId'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user1.png'), // Replace with your image
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Steve Brown', style: TextStyle(fontWeight: FontWeight.bold)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(18)),
                            child: Text('ABA', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$1.75', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('5.1 km', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('PICK UP', style: TextStyle(color: Colors.grey)),
              Text('Street360', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Divider(),
              Text('DROP OFF', style: TextStyle(color: Colors.grey)),
              Text('234 Toul Kork St, PhnomPenh', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Divider(),
              Text('NOTED', style: TextStyle(color: Colors.grey)),
              Text('Please put the item in front of the door and ring the bell.'),
              SizedBox(height: 16),
              Divider(),
              Text('PAYMENT', style: TextStyle(color: Colors.grey)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ABA Pay'),
                  Text('\$15.50'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discount'),
                  Text('\$10.00'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Paid amount', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('\$5.50', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ), 
              SizedBox(height: 24),
             
              Divider(),
               SizedBox(height: 15),
              Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          icon: Icons.phone,
          text: 'Call',
          backgroundColor: Color(0xFFB0E0C2), // Light Green
          textColor: Colors.black,
        ),
        SizedBox(width: 10),
        _buildActionButton(
          icon: Icons.message,
          text: 'Message',
          backgroundColor: Colors.blue,
          textColor: Colors.white,
        ),
        SizedBox(width: 10),
        _buildActionButton(
          icon: Icons.cancel,
          text: 'Cancel',
          backgroundColor: Colors.grey,
          textColor: Colors.white,
        ),
      ],
    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.amber,
          child: Text('GO TO PICK UP', style: TextStyle(color: Colors.black), textAlign: TextAlign.center,),
            
          ),
        ),
      );
    
  }
}


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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: textColor, size: 28),
            SizedBox(height: 5),
            Text(text, style: TextStyle(color: textColor)),
          ],
        ),
      ),
    );
  }