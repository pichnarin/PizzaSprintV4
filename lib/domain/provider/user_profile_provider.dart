import 'package:pizzaprint_v4/env/user_local_storage/secure_storage.dart';
import 'package:flutter/material.dart';

class UserProfileProvider with ChangeNotifier {
  String _username = '';
  String _email = '';
  String _profileImage = '';

  String get username => _username;
  String get email => _email;
  String get profileImage => _profileImage;

  // Flag to indicate if data has been loaded
  bool _isDataLoaded = false;

  // Method to fetch user profile and set data from secure storage
  Future<void> loadUserProfile() async {
    if (_isDataLoaded) {
      return; // If data is already loaded, don't reload.
    }

    // Fetch user profile from secure storage
    final userProfile = await secureLocalStorage.getUserProfile();
    if (userProfile != null) {
      _username = userProfile['name'] ?? 'No Name';
      _email = userProfile['email'] ?? 'No Email';
      _profileImage = userProfile['avatar'] ?? ''; // Provide a default if not available
      _isDataLoaded = true;  // Mark the data as loaded
      notifyListeners();  // Notify listeners that the profile has been updated
    }
  }

  // Method to set user profile directly (for SignInScreen or other cases)
  Future<void> setUserProfile(String username, String email, String profileImage) async {
    _username = username;
    _email = email;
    _profileImage = profileImage;
    _isDataLoaded = true;  // Mark the data as loaded

    // Store the user profile in secure storage
    await secureLocalStorage.saveUserProfile(username, email, avatar: profileImage);

    notifyListeners();  // Notify listeners that the profile has been updated
  }

  // Optional: Reset user profile
  Future<void> clearUserProfile() async {
    _username = '';
    _email = '';
    _profileImage = '';
    _isDataLoaded = false;  // Reset the data loaded flag

    // Remove user profile from secure storage
    await secureLocalStorage.deleteUserProfile();

    notifyListeners();
  }

  // Optional: Force data reload (used when user logs out or if data changes)
  Future<void> refreshUserProfile() async {
    _isDataLoaded = false;  // Reset the flag to reload the data
    await loadUserProfile();
  }
}
