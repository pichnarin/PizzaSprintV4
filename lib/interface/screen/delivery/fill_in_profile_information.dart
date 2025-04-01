// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../../component/widgets/delivery_custom_text_button.dart';
// import '../../component/widgets/delivery_dropdown.dart';
// import '../../component/widgets/delivery_fill_in_profile_textfield.dart';
// import 'home_screen.dart';

// class FillInProfileInfo extends StatefulWidget {
//   const FillInProfileInfo({super.key});

//   @override
//   State<FillInProfileInfo> createState() => _FillInProfileInfoState();
// }

// class _FillInProfileInfoState extends State<FillInProfileInfo> {
//   final TextEditingController _userNameController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();

//   String? _selectedGender = 'Male';
//   File? _image;

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(
//       source: ImageSource.gallery, 
//     );

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path); 
//       });
//   }
//   }
  
//    // Function to show date picker and update controller
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (picked != null) {
//       setState(() {
//         _dobController.text = DateFormat('dd MMM yyyy').format(picked);
//       });
//     }
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
//                 const Text(
//                   'Fill Your Profile',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 Center(
//                   child: GestureDetector(
//                     onTap: _pickImage,
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: _image != null
//                       ? FileImage(_image!) 
//                       : null,
//                       child: _image == null ? const Icon(Icons.camera_alt, size: 40) : null,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
                
//                 ReusableTextField(
//                   controller: _userNameController,
//                   hintText: "Username",
//                   keyboardType: TextInputType.text,
//                 ),
//                 const SizedBox(height: 10),
//                 ReusableTextField(
//                   controller: _dobController,
//                   hintText: "Date of Birth",
//                   onTap: () => _selectDate(context),
//                   suffixIcon: GestureDetector(
//                     onTap: () => _selectDate(context),  
//                     child: const Icon(Icons.calendar_month),
//                   ),
//                               ),
//                 const SizedBox(height: 10),
//                 ReusableDropdown(
//                   hintText: 'Select Gender',
//                   items: const ['Male', 'Female', 'Other'], 
//                   selectedValue: _selectedGender, 
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedGender = value; 
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 ReusableTextField(
//                   controller: _phoneNumberController,
//                   hintText: "Phone Number",
//                 ),
//                 const SizedBox(height: 50), 
//                 Center(
//                   child: CustomTextButton(
//                     buttonText: 'Continue', 
//                     onPressed: () {
//                       Provider.of<UserProvider>(context, listen: false).updateUser(
//                         UserProfile(
//                           userName: _userNameController.text, 
//                           phoneNumber: _phoneNumberController.text, 
//                           dob: _dobController.text,
//                           gender: _selectedGender!,
//                           imagePath: _image?.path,
//                         ),
//                       );
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomeScreen()),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//     );
//   }
// }