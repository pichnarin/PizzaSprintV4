
import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/service/google_sign_in_service.dart';
import 'package:pizzaprint_v4/interface/component/driver_widget/custom_button.dart';
import 'package:pizzaprint_v4/interface/component/driver_widget/delivery_fill_in_profile_textfield.dart';
import 'package:pizzaprint_v4/interface/component/driver_widget/delivery_social_button.dart';
import 'package:pizzaprint_v4/interface/component/driver_widget/delivey_divider.dart';
import 'package:pizzaprint_v4/interface/screen/delivery/login_page.dart';
import 'package:pizzaprint_v4/interface/theme/theme.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _isChecked = false;

  // Instance of GoogleSignInService
  final GoogleSignInService googleSignInService = GoogleSignInService();

  Future<void> _signUpWithGoogle(BuildContext context) async {
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
          await googleSignInService.sendIdTokenToBackend(idToken);
          Navigator.pushReplacementNamed(context, '/menu'); // Redirect to Menu after sign-up
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PizzaColors.backgroundAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: PizzaColors.textNormal), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Pop the current screen to go back
          },
        ),
        elevation: 0,  // Remove the shadow under the app bar
      ),
      backgroundColor: PizzaColors.backgroundAccent,  // Updated to use PizzaColors
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(PizzaSpacings.m),  // Updated to use PizzaSpacings
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: PizzaSpacings.xl),
            Text(
              'Create your\nAccount',
              style: PizzaTextStyles.heading,  // Use pizza theme heading style
            ),
            const SizedBox(height: PizzaSpacings.l),
            ReusableTextField(
              controller: _nameController,
              hintText: "Name",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: PizzaSpacings.s),
            ReusableTextField(
              controller: _phoneNumberController,
              hintText: "Phone number",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: PizzaSpacings.s),
            ReusableTextField(
              controller: _passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: PizzaSpacings.s),
            ReusableTextField(
              controller: _confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),
            const SizedBox(height: PizzaSpacings.l),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                  child: Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: "I agree to the ",
                      style: TextStyle(color: PizzaColors.textNormal, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Terms & Conditions",
                          style: TextStyle(
                            color: PizzaColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: " and acknowledge the Privacy Policy.",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: PizzaSpacings.l),
            Center(
              child: CustomButton(
                buttonText: 'Create Account',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FillInProfileInfo()),
                  );
                },
              ),
            ),
            const SizedBox(height: PizzaSpacings.l),
            const OrDivider(text: 'or continue with'),
            const SizedBox(height: PizzaSpacings.l),
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
                const SizedBox(width: PizzaSpacings.m),
                SocialButton(
                  label: "Google",
                  iconPath: "assets/icons/google.png",
                  onPressed: () => _signUpWithGoogle(context),  // Trigger Google sign-up
                  isCompact: true,
                  width: 70,
                ),
                const SizedBox(width: PizzaSpacings.m),
                SocialButton(
                  label: "Apple",
                  iconPath: "assets/icons/apple.png",
                  onPressed: () => print("Apple Login"),
                  isCompact: true,
                  width: 70,
                ),
              ],
            ),
            const SizedBox(height: PizzaSpacings.m),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: PizzaColors.textLight,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text(
                    ' Sign in',
                    style: TextStyle(
                      color: PizzaColors.primary,
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
