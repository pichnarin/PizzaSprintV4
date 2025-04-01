import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';
import '../../component/driver_widget/delivery_fill_in_profile_textfield.dart';
import '../../component/driver_widget/delivery_social_button.dart';
import '../../component/driver_widget/delivey_divider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Login to your\nAccount',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 30),
              ReusableTextField(
                controller: _nameController,
                hintText: "Name",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10),
              ReusableTextField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 50),

              const SizedBox(height: 30),
              const OrDivider(text: 'or continue with',),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SocialButton(
                    label: "Facebook",
                    iconPath: "assets/icons/facebook.png",
                    onPressed: () => print("Facebook Login"),
                    isCompact: true,
                    width: 70,
                    
                  ),
                  const SizedBox(width: 30),
                  SocialButton(
                    label: "Google",
                    iconPath: "assets/icons/google.png",
                    onPressed: () => print("Google Login"),
                    isCompact: true,
                    width: 70, 
                  ),
                  const SizedBox(width: 30),
                  SocialButton(
                    label: "Apple",
                    iconPath: "assets/icons/apple.png",
                    onPressed: () => print("Apple Login"),
                    isCompact: true,
                    width: 70,
                    
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppPallete.secondaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}