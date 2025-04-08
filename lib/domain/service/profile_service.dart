import 'package:pizzaprint_v4/env/user_local_storage/secure_storage.dart';

class ProfileService {
  // Method to store the user profile in secure storage
  Future<void> storeUserProfile(String name, String email) async {
    await secureLocalStorage.saveUserProfile(name, email);
  }

  // Method to fetch the user profile from secure storage
  Future<Map<String, String>?> fetchUserProfile() async {
    return await secureLocalStorage.getUserProfile();
  }

  // Method to clear the user profile from secure storage (logout)
  Future<void> clearUserProfile() async {
    await secureLocalStorage.deleteUserProfile();
  }
}
