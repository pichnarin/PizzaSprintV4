import 'package:flutter/material.dart';

class PizzaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PizzaButton({
    Key? key,
    required this.label,
    required this.onPressed, required String type, required IconData icon, required Color backgroundColor, required MaterialColor textColor, required TextStyle style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

