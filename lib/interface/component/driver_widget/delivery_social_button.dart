import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';


class SocialButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;
  final bool isCompact;
  final double width;
  final double height;

  const SocialButton({
    required this.label,
    required this.iconPath,
    required this.onPressed,
    this.isCompact = false,
    this.width = 280,
    this.height = 45,
    super.key
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
        child: isCompact
          ? Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppPallete.border, width: 1),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: IconButton(
                onPressed: onPressed,
                icon: Image.asset(iconPath, width: 32, height: 32), 
            ),
          )
        : ElevatedButton.icon(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
                side: BorderSide(color: AppPallete.border, width: 1)
              ),
              backgroundColor: Colors.white,
            ),
            icon: Image.asset(iconPath, width: 32, height: 32),
            label: Text(
              label,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
        ),
    );
  }
}