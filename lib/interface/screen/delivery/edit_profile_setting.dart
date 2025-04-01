// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';


// class EditProfileSetting extends StatefulWidget {

//   const EditProfileSetting({
//     super.key,
//   });

//   @override
//   State<EditProfileSetting> createState() => _EditProfileSettingState();
// }

// class _EditProfileSettingState extends State<EditProfileSetting> {


//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(
//       source: ImageSource.gallery, 
//     );

//     if (pickedFile != null) {
//       setState(() {
//         _imagePath = pickedFile.path; 
//       });
    
//     }
//   }


//   late TextEditingController _nameController;
//   late TextEditingController _dobController;
//   late TextEditingController _phoneController;
//   String? _selectedGender;
//   String? _imagePath;
  

//   @override
//   void initState() {
//     super.initState();
//     final user = Provider.of<UserProvider>(context, listen: false).user;
//     _nameController = TextEditingController(text: user.userName);
//     _phoneController = TextEditingController(text: user.phoneNumber);
//     _dobController = TextEditingController(text: user.dob);
//     _selectedGender = user.gender;
//     _imagePath = user.imagePath;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//             }
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                 // Profile Picture
//               Center(
//                 child: GestureDetector(
//                   onTap: _pickImage,
//                   child:  
//                     Stack(
//                       children: [
//                         CircleAvatar(
//                           radius: 50,
//                           backgroundImage: _imagePath != null
//                               ? FileImage(File(_imagePath!)) as ImageProvider
//                               : const AssetImage('assets/images/user1.png'),
//                         ), 
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.all(4),
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(Icons.add_circle, color: Colors.grey),
//                           ),
//                         ),
//                       ]
                    
//                     ),
//                   )
//               ),
//               const SizedBox(height: 30),
//               const Text('Your Name'),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   border: UnderlineInputBorder(),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.amber, width: 2),
//                   ),
//                 ),
//               ),             
//               const SizedBox(height: 40),
//               const Text('Phone number'),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(
//                   border: UnderlineInputBorder(),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.amber),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 50),
//               // Save Button
//               Center(
//                 child: CustomTextButton(
//                   buttonText: 'Save',
//                   onPressed: () {
//                     Provider.of<UserProvider>(context, listen: false).updateUser(
//                     UserProfile(
//                     userName: _nameController.text,
//                     phoneNumber: _phoneController.text,
//                     dob: _dobController.text,
//                     gender: _selectedGender!,
//                     imagePath: _imagePath,
//                   ),
                
//                 );
//                 Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ); 
//   }
// }
