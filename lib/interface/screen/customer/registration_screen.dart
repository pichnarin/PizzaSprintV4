// import 'package:flutter/material.dart';
// import 'package:frontend/interface/component/widgets/custom_button.dart';
// import 'package:frontend/interface/component/widgets/social_button.dart';
// import 'package:frontend/interface/component/widgets/divider.dart';
// import 'package:frontend/interface/screen/delivery/login_page.dart';
// import 'package:frontend/interface/theme/app_pallete.dart'; // Import AppPallete for the theme
// import '../../services/auth_service.dart';
// import '../../theme/theme.dart'; // Import AuthService for registration

// class RegistrationPage extends StatefulWidget {
//   const RegistrationPage({super.key});

//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _authService = AuthService();
//   final _formKey = GlobalKey<FormState>(); // Form validation key

//   bool _isLoading = false;

//   // Registration method
//   void _register() async {
//     if (!_formKey.currentState!.validate()) {
//       return; // Exit if form is invalid
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final response = await _authService.signup({
//         'email': _emailController.text,
//         'password': _passwordController.text,
//       });

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Account created successfully!")),
//       );

//       // Redirect to Login Page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     } catch (e) {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Registration failed! ${e.toString()}")),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: PizzaColors.backgroundAccent, // Use theme background color
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(PizzaSpacings.m), // Using spacing from theme
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset('assets/images/pickoff-guy.png', width: 300, height: 300),
//               const SizedBox(height: PizzaSpacings.l), // Using spacing from theme
//               Text(
//                 'Create Your Account',
//                 style: PizzaTextStyles.heading,
//               ),
//               const SizedBox(height: PizzaSpacings.m),

//               // Social Login Buttons
//               SocialButton(
//                 iconPath: 'assets/icons/facebook.png',
//                 label: 'Continue with Facebook',
//                 onPressed: () => print("Facebook Login"),
//               ),
//               const SizedBox(height: PizzaSpacings.s),
//               SocialButton(
//                 iconPath: 'assets/icons/google.png',
//                 label: 'Continue with Google',
//                 onPressed: () => print("Google Login"),
//               ),
//               const SizedBox(height: PizzaSpacings.s),
//               SocialButton(
//                 iconPath: 'assets/icons/apple.png',
//                 label: 'Continue with Apple',
//                 onPressed: () => print("Apple Login"),
//               ),
//               const SizedBox(height: PizzaSpacings.xl),

//               // OR Divider
//               const OrDivider(),
//               const SizedBox(height: PizzaSpacings.l),

//               // Registration Form
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // Email input field
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         labelStyle: PizzaTextStyles.label,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: PizzaColors.primary),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                           return 'Please enter a valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: PizzaSpacings.s),

//                     // Password input field
//                     TextFormField(
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         labelStyle: PizzaTextStyles.label,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: PizzaColors.primary),
//                         ),
//                       ),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         if (value.length < 6) {
//                           return 'Password should be at least 6 characters long';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: PizzaSpacings.l),

//                     // Register Button or loading indicator
//                     _isLoading
//                         ? const CircularProgressIndicator()
//                         : CustomButton(
//                             buttonText: 'Create Account',
//                             onPressed: _register,
//                           ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: PizzaSpacings.xl),

//               // Already have an account?
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Already have an account?',
//                     style: PizzaTextStyles.body.copyWith(
//                       color: PizzaColors.secondary, // Using secondary color
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => const LoginPage()),
//                       );
//                     },
//                     child: Text(
//                       'Login',
//                       style: PizzaTextStyles.body.copyWith(
//                         color: PizzaColors.primary, // Using primary color
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
