import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/pizza_button.dart';


class LocationSelectionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LocationSelectionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PizzaButton(
      label: "Select Location", // Button label text
      onPressed: onPressed, // The onPressed callback
      icon: Icons.location_on, // Add the location icon
      type: 'secondary', // Optional, set as secondary to match the style
      backgroundColor: Colors.red, // Add the required backgroundColor argument
      textColor: Colors.white as MaterialColor, // Add the required textColor argument
      style: TextStyle(fontSize: 16), // Add the required style argument
    );
  }
}
