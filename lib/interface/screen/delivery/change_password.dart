
// import 'package:flutter/material.dart';
// import 'package:frontend/interface/screen/delivery/email_verification.dart';

// import '../../component/widgets/delivery_custom_text_button.dart';
// import '../../component/widgets/textfield.dart';


// class ChangePassword extends StatefulWidget {
//   const ChangePassword({super.key});

//   @override
//   State<ChangePassword> createState() => _ChangePasswordState();
// }

// class _ChangePasswordState extends State<ChangePassword> {
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 50),
//                 const Text(
//                   'Change Password',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 const Text(
//                   'Enter your email address to receive a reset link',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Email Address",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     ReusableTextField(
//                       controller: _emailController,
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 50),
//                 Center(
//                   child: Column(
//                     children: [
//                       CustomTextButton(
//                         buttonText: 'Continue', 
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => const EmailVerification()),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),       
//               ],
//             ),
//           ),
//         ),
//     );
//   }
// }
