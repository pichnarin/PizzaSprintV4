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
//                   backgroundImage: user.avatar != null 
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






// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:frontend/domain/provider/user_provider.dart';
// import 'package:frontend/interface/component/widgets/delivery_custom_icon_button.dart';
// import 'package:frontend/env/user_local_storage/secure_storage.dart';
// import 'package:frontend/env/environment.dart';
// import 'package:frontend/interface/screen/delivery/login_screen.dart';
// import 'package:provider/provider.dart';

// class ProfileSetting extends StatelessWidget {
//   const ProfileSetting({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     final user = userProvider.user;
    
//     // If the user is not yet fetched, show a loading spinner
//     if (user == null && userProvider.isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('My Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           backgroundColor: Colors.transparent,
//         ),
//         body: Center(child: CircularProgressIndicator()), // Loading indicator
//       );
//     }

//     // If there's an error while fetching the user profile
//     if (user == null && userProvider.error != null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('My Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           backgroundColor: Colors.transparent,
//         ),
//         body: Center(child: Text(userProvider.error ?? 'Error loading profile')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
//             Column(
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: (user.avatar != null && user.avatar!.isNotEmpty)
//                       ? FileImage(File(user.avatar!)) as ImageProvider
//                       : const AssetImage('assets/images/user1.png'),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   user.avatar!,
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 // Uncomment and modify if you have other user data like email
//                 // Text(
//                 //   'useremail@example.com',
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
//                 // Navigator.push(
//                 //   context, 
//                 //   MaterialPageRoute(builder: (context) => const EditProfileSetting())
//                 // );
//               }, 
//             ),
//             const SizedBox(height: 10),
//             CustomIconButton(
//               icon: Icons.lock_outline, 
//               text: 'Change Password', 
//               iconBackgroundColor: Colors.amber,
//               onTap: () {
//                 // Navigator.push(
//                 //   context, 
//                 //   MaterialPageRoute(builder: (context) => const ChangePassword())
//                 // );
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
//               onTap: () async {
//                 await secureLocalStorage.deleteToken(); // Log out by deleting token
//                 Navigator.pushReplacement(
//                   context, 
//                   MaterialPageRoute(builder: (context) => const LoginScreen()) // Redirect to login
//                 );
//               }, 
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/provider/user_provider.dart';
import '../../../env/user_local_storage/secure_storage.dart';
import '../../component/driver_widget/delivery_custom_icon_button.dart';
import 'login_screen.dart';


class ProfileSetting extends StatelessWidget {
  const ProfileSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    // Show loading screen if the user is being fetched or is null
    if (user == null && userProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Show error message if there is an issue fetching the user data
    if (user == null && userProvider.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
        ),
        body: Center(child: Text(userProvider.errorMessage ?? 'Error loading profile')),
      );
    }

    // If user data is available, show profile page
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigator.push(
              //   context, 
              //   MaterialPageRoute(builder: (context) => const EditProfileSetting())
              // );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture and Name
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: (user?.avatar != null && user!.avatar.isNotEmpty)
                      ? NetworkImage(user.avatar)
                      : const AssetImage('assets/images/user1.png'),
                ),
                const SizedBox(height: 8),
                Text(
                  user?.name ?? 'User', 
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  user?.email ?? 'no email found!',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 24),

            CustomIconButton(
              icon: Icons.edit_outlined, 
              text: 'Edit Profile', 
              iconBackgroundColor: Colors.amber,
              onTap: () {
                // Navigator.push(
                //   context, 
                //   MaterialPageRoute(builder: (context) => const EditProfileSetting())
                // );
              }, 
            ),
            const SizedBox(height: 10),
            CustomIconButton(
              icon: Icons.lock_outline, 
              text: 'Change Password', 
              iconBackgroundColor: Colors.amber,
              onTap: () {
                // Navigator.push(
                //   context, 
                //   MaterialPageRoute(builder: (context) => const ChangePassword())
                // );
              },  
            ),
            const SizedBox(height: 10),
            CustomIconButton(
              icon: Icons.info_outline, 
              text: 'Information', 
              iconBackgroundColor: Colors.amber,
              onTap: () {}, 
            ),
            const SizedBox(height: 10),
            CustomIconButton(
              icon: Icons.sync, 
              text: 'Update', 
              iconBackgroundColor: Colors.amber,
              onTap: () {}, 
            ),
            const SizedBox(height: 30),
            CustomIconButton(
              icon: Icons.logout_outlined, 
              text: 'Log out', 
              iconBackgroundColor: Colors.amber,
              onTap: () async {
                await secureLocalStorage.deleteToken(); 
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const LoginScreen()) 
                );
              }, 
            ),
          ],
        ),
      ),
    );
  }
}
