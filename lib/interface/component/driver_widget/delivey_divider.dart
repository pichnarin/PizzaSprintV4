import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';


class OrDivider extends StatelessWidget {
  final double lineWidth;
  final double thickness;
  final String text;
  final Color lineColor;
  final double spacing;

  const OrDivider({
    super.key,
    this.lineWidth = 120, 
    this.thickness = 1, 
    this.text = "or", 
    this.lineColor = AppPallete.secondaryText, 
    this.spacing = 12, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: lineWidth,
          child: Divider(
            color: lineColor,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: Text(text),
        ),
        SizedBox(
          width: lineWidth,
          child: Divider(
            color: lineColor,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}
