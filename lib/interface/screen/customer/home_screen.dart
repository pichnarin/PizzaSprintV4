import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/component/customer_widget/slide_to_start_button.dart';
import 'package:pizzaprint_v4/interface/theme/theme.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PizzaColors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: PizzaSpacings.m),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Welcome Message
              Text(
                "Welcome to Pizza Delivery!",
                style: PizzaTextStyles.heading.copyWith(
                  color: PizzaColors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: PizzaSpacings.l),

              // Adjusted spacing (Just in case)
              const SizedBox(height: PizzaSpacings.xxl * 8),

              // Slide Button
              SlideToStartButton(
                backgroundColor: PizzaColors.secondary,
                buttonColor: PizzaColors.primary,
                textColor: PizzaColors.white.withOpacity(0.9),
                onSlideComplete: () async {
                  // Navigate to the Sign-In Screen
                  Navigator.pushNamed(context, '/signIn');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
