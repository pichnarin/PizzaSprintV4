// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import '../../component/widgets/delivery_custom_text_button.dart';
// import '../../theme/theme.dart';



// class EmailVerification extends StatefulWidget {
//   const EmailVerification({super.key});

//   @override
//   State<EmailVerification> createState() => _EmailVerificationState();
// }

// class _EmailVerificationState extends State<EmailVerification> {

//   TextEditingController otpController = TextEditingController();
//   StreamController<int> countdownStream = StreamController<int>();
//   int countdown = 45; // Initial countdown time
//   String correctOTP = "3721"; // Simulated correct OTP (Replace with backend OTP)

  
//   @override
//   void initState() {
//     super.initState();
//     startCountdown();
//   }
//   void startCountdown() {
//     countdownStream.add(countdown);
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       if (countdown > 0) {
//         countdown--;
//         countdownStream.add(countdown);
//       } else {
//         timer.cancel();
//       }
//     });
//   }
//   void verifyOTP(String enteredOTP) {
//     if (enteredOTP == correctOTP) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("OTP Verified!")),
//       );
//       // Navigate to the next screen or perform further actions here
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Invalid OTP, please try again!")),
//       );
//     }
//   }

//   void resendOTP() {
//     setState(() {
//       otpController.clear();
//       countdown = 45;
//       startCountdown();
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("New OTP sent to your email!")),
//     );
//   }
//   @override
//   void dispose() {
//     otpController.dispose();
//     countdownStream.close();
//     super.dispose();
//   }

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
//                   'Email Verification',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 const Text(
//                   'Please enter the code we sent to your email address',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 PinCodeTextField(
//                   appContext: context, 
//                   length: 4,
//                   controller: otpController,
//                   keyboardType: TextInputType.number,
//                   pinTheme: PinTheme(
//                     shape: PinCodeFieldShape.box,
//                     borderRadius: BorderRadius.circular(8),
//                     fieldHeight: 50,
//                     fieldWidth: 50,
//                     activeColor: Colors.yellow,
//                     inactiveColor: Colors.grey.shade300,
//                     selectedColor: Colors.black,
//                   ),
//                   onChanged: (value) {},
//                 ),
//                 const SizedBox(height: 10),
//                 Center(
//                   child: StreamBuilder<int>(
//                     stream: countdownStream.stream,
//                     builder: (context, snapshot) {
//                       return GestureDetector(
//                         onTap: snapshot.data == 0 ? resendOTP : null,
//                         child: RichText(
//                           text: TextSpan(
//                             children: [
//                               const TextSpan(
//                                 text: "Didn't receive code? ",
//                                 style: TextStyle(color: AppPallete.secondaryText, fontWeight: FontWeight.w500),
//                               ),
//                               TextSpan(
//                                 text: snapshot.data! > 0
//                                     ? "Resent in ${snapshot.data}s"
//                                     : "Resend Code",
//                                 style: TextStyle(
//                                   color: AppPallete.signInUpText,//snapshot.data! > 0 ? Colors.grey : Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 Center(
//                   child: Column(
//                     children: [
//                       CustomTextButton(
//                         buttonText: 'Continue', 
//                         onPressed: () {
//                           if (otpController.text.length == 4) {
//                             verifyOTP(otpController.text);
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text("Enter a 4-digit OTP!")),
//                             );
//                           }
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