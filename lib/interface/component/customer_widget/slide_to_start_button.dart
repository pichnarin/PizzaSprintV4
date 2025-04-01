import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For vibration feedback

class SlideToStartButton extends StatefulWidget {
  final VoidCallback onSlideComplete; // Callback when slide is completed
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  const SlideToStartButton({
    super.key,
    required this.onSlideComplete,
    this.backgroundColor = Colors.blue,
    this.buttonColor = Colors.white,
    this.textColor = Colors.white70,
  });

  @override
  _SlideToStartButtonState createState() => _SlideToStartButtonState();
}

class _SlideToStartButtonState extends State<SlideToStartButton> {
  double _slidePosition = 0.0; // Position of the sliding button
  final double _maxSlide = 250.0; // The max slide distance

  // Called during drag update
  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _slidePosition += details.primaryDelta ?? 0.0;  // Update position
      if (_slidePosition < 0) _slidePosition = 0;  // Don't let it go below 0
      if (_slidePosition > _maxSlide) _slidePosition = _maxSlide;  // Don't let it go beyond max
    });
  }

  // Called when drag ends
  void _onDragEnd(DragEndDetails details) {
    if (_slidePosition >= _maxSlide - 20) {  // If the slide is complete (close to the max slide position)
      HapticFeedback.lightImpact();  // Vibrate feedback
      widget.onSlideComplete();  // Trigger the action
    } else {
      // Reset position immediately without animation
      setState(() {
        _slidePosition = 0; // This line was missing!
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        // Background Bar
        Container(
          width: _maxSlide + 60,  // Adjust width for visual space
          height: 60,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        // "Slide to Start" Text
        Positioned.fill(
          child: Center(
            child: Text(
              "Slide to Start",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.textColor,
              ),
            ),
          ),
        ),

        // Draggable Button
        Positioned( // Changed to Positioned, no animation
          left: _slidePosition,
          child: GestureDetector(
            onHorizontalDragUpdate: _onDragUpdate,  // Update slide position
            onHorizontalDragEnd: _onDragEnd,  // End drag and decide action
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: widget.buttonColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }
}