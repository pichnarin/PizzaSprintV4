import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:pizzaprint_v4/interface/screen/customer/cart_screen.dart';
import 'package:pizzaprint_v4/interface/screen/customer/menu_screen.dart';
import 'package:pizzaprint_v4/interface/screen/customer/profile_screen.dart';

import '../../screen/customer/order_detail_screen.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  Widget _currentScreen = MenuScreen();

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _currentScreen = MenuScreen();
          break;
        case 1:
          _currentScreen = const CartScreen();
          break;
        case 2:
          _currentScreen = const UserProfileScreen();
          break;
          case 3:
          _currentScreen = OrderDetailScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentScreen,
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: const Color.fromARGB(255, 235, 132, 64),
        items: const [
          TabItem(icon: Icons.local_pizza, title: "Menu"),
          TabItem(icon: Icons.shopping_bag, title: "Cart"),
          TabItem(icon: Icons.person, title: "Profile"),
          TabItem(icon: Icons.history, title: "Order History"),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}