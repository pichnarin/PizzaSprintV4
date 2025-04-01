import 'package:flutter/material.dart';
import '../../component/driver_widget/delivery_custom_bottom_navigation_bar.dart';
import '../../component/driver_widget/delivery_order_card.dart';
import 'delivery_history.dart';
import 'notification_screen.dart';
import 'order.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // List of widgets to display for each tab
  late List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreenContent(), 
      ActiveOrder(),
      DeliveryHistory(),
      DeliveryHistory(),
      //ProfileSetting(),
    ];
  }

  // Method to handle tab changes
  void _onTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTab,
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text('HomeScreen', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => NotificationScreen())
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[300],
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: OrderCard(
              name: 'Steve Brown',
              avatar: 'assets/images/user1.png',
              paymentMethod: 'ABA',
              price: '1.75',
              distance: '5.1',
              pickupLocation: 'Street360',
              dropoffLocation: '234 ToulKork St, PhnomPenh',
              onAccept: () {},
              onIgnore: () {},
            ),
          ),
        ],
      ),
    );
  }
}