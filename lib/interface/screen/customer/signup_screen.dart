import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add Firebase Auth for email/password sign-in
import 'package:pizzaprint_v4/domain/service/google_sign_in_service.dart';
import 'package:pizzaprint_v4/interface/component/driver_widget/custom_button.dart';
import 'package:pizzaprint_v4/interface/component/driver_widget/delivery_social_button.dart';
import 'package:pizzaprint_v4/interface/component/driver_widget/delivey_divider.dart';
import 'package:pizzaprint_v4/interface/theme/app_pallete.dart';
import 'package:provider/provider.dart';

import '../../../domain/provider/user_profile_provider.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleSignInService googleSignInService = GoogleSignInService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Sign in using Google
  Future<void> _signInWithGoogle(BuildContext context) async {
    final userCredential = await googleSignInService.signInWithGoogle();
    if (userCredential == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign-In failed or cancelled.')),
      );
    } else {
      final user = userCredential.user;
      if (user != null) {
        final idToken = await user.getIdToken();
        if (idToken != null) {

          // Set user profile information in the provider
          Provider.of<UserProfileProvider>(context, listen: false).setUserProfile(
            user.displayName ?? '',  // Set username (or empty if not available)
            user.email ?? '',         // Set email
            user.photoURL ?? '',      // Set profile image URL
          );

          await googleSignInService.sendIdTokenToBackend(idToken);
          Navigator.pushReplacementNamed(context, '/menu'); // ✅ Redirect to Menu
        }
      }
    }
  }

  // Sign in using Email and Password
  Future<void> _signInWithEmailPassword(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password.')),
      );
      return;
    }

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        // Set user profile information in the provider
        Provider.of<UserProfileProvider>(context, listen: false).setUserProfile(
          userCredential.user!.displayName ?? '',  // Set username (or empty if not available)
          userCredential.user!.email ?? '',         // Set email
          userCredential.user!.photoURL ?? '',      // Set profile image URL
        );
        Provider.of<UserProfileProvider>(context, listen: false).refreshUserProfile();

        // If successful, navigate to the menu screen
        Navigator.pushReplacementNamed(context, '/menu');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppPallete.textColor), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Pop the current screen to go back
          },
        ),
        elevation: 0,  // Optional: Removes the shadow under the app bar
      ),
      backgroundColor: AppPallete.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Sign In to your\nAccount',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // Email and Password Fields
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Email/Password Sign In Button
            Center(
              child: CustomButton(
                buttonText: 'Sign in',
                onPressed: () => _signInWithEmailPassword(context),
              ),
            ),
            const SizedBox(height: 30),
            const OrDivider(text: 'or continue with'),
            const SizedBox(height: 30),

            // Social Media Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  onPressed: () => _signInWithGoogle(context),
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signUp');
                  },
                  child: const Text(
                    ' Sign Up',
                    style: TextStyle(
                      color: AppPallete.signInUpText,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
