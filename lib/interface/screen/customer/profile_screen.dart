import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/env/user_local_storage/secure_storage.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:pizzaprint_v4/domain/provider/user_profile_provider.dart'; // Import UserProfileProvider

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Load user profile via the provider
  Future<void> _loadUserProfile() async {
    try {
      await Provider.of<UserProfileProvider>(context, listen: false).loadUserProfile();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // Handle any errors that might occur during loading the profile
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user profile: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method to display user info
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
              value.isEmpty ? 'Not Provided' : value,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
        ),
      ],
    ),
  );
  // Logout button
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
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // Clear user profile data from secure storage
                await secureLocalStorage.deleteUserProfile();
                // Reset the provider data as well
                Provider.of<UserProfileProvider>(context, listen: false).clearUserProfile();
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/home'); // Navigate to the home screen
              },
              child: const Text('OK', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Color.fromRGBO(64, 105, 225, 1)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  userProfileProvider.profileImage.isEmpty
                      ? 'https://your-default-avatar.png' // Make sure you use a real default image or a local one
                      : userProfileProvider.profileImage,
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildUserInfoDisplay(userProfileProvider.username, 'Name'),
            buildUserInfoDisplay(userProfileProvider.email, 'Email'),
            // buildAbout('Bio: ${userProfileProvider.username}'),
            const SizedBox(height: 20),
            buildLogoutButton(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
