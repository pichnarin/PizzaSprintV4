
import 'package:flutter/material.dart';

class DeliveryLocation extends StatelessWidget {
  const DeliveryLocation({super.key});

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
        title: const Text('Destination'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.amber,
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              children: [
                Icon(Icons.navigation, color: Colors.black),
                SizedBox(width: 8.0),
                Text(
                  '250m Turn right at 360 St, Phnom Penh',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              'assets/images/map2.jpg', 
            ),
          ),
          
          const SizedBox(width: 16.0),
          _buildClickablePickupCard(context),
              ],
            ),
          );
  }
  Widget _buildClickablePickupCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPickupDetailsBottomSheet(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)), // Rounded top only
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -3), // Shadow above the container
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text('A', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pick up at'),
                Text('Street360'),
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  void _showPickupDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView( // Make the content scrollable
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text('A', style: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pick up at'),
                        Text('Street360'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('EST'),
                        Text('5 min'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Distance'),
                        Text('2.2 km'),
                      ],
                    ),
                    Column(
                      children: [
                        Text('EST'),
                        Text('\$5.50'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.amber,
                    ),
                    child: const Text('DROP OFF'),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16.0),
                _buildRouteStep(Icons.arrow_upward, 'Head southest on Madison St', '400 m'),
                _buildRouteStep(Icons.subdirectory_arrow_left, 'Turn left onto 4th Ave', '150 m'),
                _buildRouteStep(Icons.subdirectory_arrow_right, 'Turn right at 105th N Link Rd', '250 m'),
                _buildRouteStep(Icons.subdirectory_arrow_right, 'Turn right at 360 St, Phnom Penh', '1.1 km'),
                _buildRouteStep(Icons.arrow_upward, 'Continue straight to stay on Vancouver', '200 m'),
                _buildRouteStep(Icons.arrow_upward, 'Keep left, follow signs for SF Intl Airport', '50 m'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRouteStep(IconData icon, String title, String distance) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(distance, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}