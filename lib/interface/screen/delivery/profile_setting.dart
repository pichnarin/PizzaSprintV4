// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:frontend/interface/component/widgets/delivery_custom_icon_button.dart';
// import 'package:provider/provider.dart';



// class ProfileSetting extends StatelessWidget {
//   const ProfileSetting({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context); 
//     final user = userProvider.user;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//             'My Profile', 
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               Navigator.push(
//                 context, 
//                 MaterialPageRoute(builder: (context) => const EditProfileSetting())
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Profile Picture and Name
//              Column(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: user.imagePath != null 
//                       ? FileImage(File(user.imagePath!)) as ImageProvider
//                       : const AssetImage('assets/images/user1.png'),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   user.userName,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 // Text(
//                 //   'pizzasprint@gmail.com',
//                 //   style: TextStyle(color: Colors.grey),
//                 // ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             CustomIconButton(
//               icon: Icons.edit_outlined, 
//               text: 'Edit Profile', 
//               iconBackgroundColor: Colors.amber,
//               onTap: () {
//                 Navigator.push(
//                 context, 
//                 MaterialPageRoute(builder: (context) => const EditProfileSetting())
//               );
//               }, 
//             ),
//             const SizedBox(height: 10),
//             CustomIconButton(
//               icon: Icons.lock_outline, 
//               text: 'Change Password', 
//               iconBackgroundColor: Colors.amber,
//               onTap: () {
//                 Navigator.push(
//                 context, 
//                 MaterialPageRoute(builder: (context) => const ChangePassword())
//               );
//               },  
//             ),
//             const SizedBox(height: 10),
//             CustomIconButton(
//               icon: Icons.info_outline, 
//               text: 'Information', 
//               iconBackgroundColor: Colors.amber,
//               onTap: () {}, 
//             ),
//             const SizedBox(height: 10),
//             CustomIconButton(
//               icon: Icons.sync, 
//               text: 'Update', 
//               iconBackgroundColor: Colors.amber,
//               onTap: () {}, 
//             ),
//             const SizedBox(height: 30),
//             CustomIconButton(
//               icon: Icons.logout_outlined, 
//               text: 'Log out', 
//               iconBackgroundColor: Colors.amber,
//               onTap: () {}, 
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }