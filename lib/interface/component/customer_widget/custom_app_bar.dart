import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? selectedLocation;
  final Function onLocationPressed;

  CustomAppBar({
    required this.title,
    required this.onLocationPressed,
    this.selectedLocation,
  });

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 228, 168, 4),
            ),
          ),
          if (selectedLocation != null)
            Text(
              'Delivery to: $selectedLocation',
              style: TextStyle(
                fontSize: 16.0,
                color: const Color.fromARGB(255, 212, 122, 5).withOpacity(0.7),
              ),
            ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // You can change this to match your app's theme
      foregroundColor: const Color.fromARGB(255, 224, 168, 13),
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(Icons.location_on),
          onPressed: () => onLocationPressed(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
