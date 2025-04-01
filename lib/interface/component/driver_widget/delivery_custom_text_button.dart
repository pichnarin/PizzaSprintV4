import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.buttonText, required this.onPressed});
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 50),
          backgroundColor: AppPallete.button,
          shadowColor: AppPallete.button,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), 
        ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
  }
}