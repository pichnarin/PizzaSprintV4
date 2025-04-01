import 'package:flutter/material.dart';
class SwipeButton extends StatelessWidget {
  final Widget destinationScreen; 

  SwipeButton({required this.destinationScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // Swipe right
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationScreen),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.yellow.shade100, 
          borderRadius: BorderRadius.circular(30), 
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, 
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.yellow, 
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.double_arrow,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Swipe to explore",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}