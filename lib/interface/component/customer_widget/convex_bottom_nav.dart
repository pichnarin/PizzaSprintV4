// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

class ReactStyleConvexAppBar extends StatelessWidget {
  final Function(int) onItemTapped;

  const ReactStyleConvexAppBar({
    super.key,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.react,
      backgroundColor: const Color.fromARGB(255, 235, 132, 64),
      items: const [
        TabItem(icon: Icons.local_pizza, title: "Menu"),
        TabItem(icon: Icons.shopping_bag, title: "Cart"),
        TabItem(icon: Icons.person, title: "Profile"),
      ],
      initialActiveIndex: 0,
      onTap: onItemTapped,
    );
  }
}
