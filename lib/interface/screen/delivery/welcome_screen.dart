import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';
import '../../component/driver_widget/delivery_swipe_button.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset('assets/images/logo_locat.png', width: 200, height: 200,),
            const Text(
              'Pizza Sprint',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: AppPallete.title,
              ),
            ),
            const Text(
              'Drive. Deliver. Delight',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/delivery-guy.png',
              width: 300, height: 300
            ),
            const SizedBox(height: 10,),
            SwipeButton(destinationScreen: LoginScreen())
          ],
        ),
      ),
    );
       
  }
}