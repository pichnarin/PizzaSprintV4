// import 'package:flutter/material.dart';

// class UserProfileScreen extends StatelessWidget {
//   const UserProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Profile"),
//         backgroundColor: Colors.orangeAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Center(
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: AssetImage("assets/images/user_avatar.png"), // Change path as needed
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "Marvis Ighedosa",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Text("Dosamarvis@gmail.com"),
//             const SizedBox(height: 8),
//             const Text("+234 9011039271"),
//             const SizedBox(height: 8),
//             const Text("No 15 Uti Street, Off Ovie Palace Road, Effurun, Delta State"),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Add edit functionality
//               },
//               child: const Text("Edit Profile"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color.fromRGBO(64, 105, 225, 1),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
      ),
      body: SingleChildScrollView( // Make it scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6hw785Erl1suQt1-j1UM6ejHtmOeJ1XnankcmnFlcSrVOpU1K53aZli3ahKL88fsnX68hJC7_zsWOmiKOi74ceQ'),
              ),
            ),
            const SizedBox(height: 20),
            buildUserInfoDisplay('Marn Vannda', 'Name'),
            buildUserInfoDisplay('+1 234 567 890', 'Phone'),
            buildUserInfoDisplay('VD.skull@gmail.com', 'Email'),
            buildAbout(
                "This is a short bio about the user. You can replace it with actual content."),
            const SizedBox(height: 20),
            buildLogoutButton(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildUserInfoDisplay(String value, String title) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildAbout(String aboutText) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tell Us About Yourself',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  aboutText,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () => _showLogoutDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Log Out',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print('User logged out'); // Replace with actual logout logic
              },
              child: const Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}