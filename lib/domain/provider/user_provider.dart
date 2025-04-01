import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../env/environment.dart';
import '../../env/user_local_storage/secure_storage.dart';

class UserProvider with ChangeNotifier {
  bool isLoading = false; // Track loading state
  String? errorMessage; // Store errors

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners(); // Notify UI to update

    try {
      final response = await http.post(
        Uri.parse('${Environment.endpointApi}/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String jwtToken =
            data['token'] ?? 'No JWT received'; // Handle missing key

        // Store the JWT token securely
        await secureLocalStorage.persistentToken(jwtToken);

        // Retrieve the stored token to verify
        final String? storedToken = await secureLocalStorage.retrieveToken();

        // Debug prints
        print('Stored token: $storedToken');
        print("User login successful");
        print("Response body: ${response.body}");

        // Successfully logged in
        isLoading = false;
        notifyListeners();
        return true; // Login was successful
      } else {
        errorMessage = "Invalid email or password";
      }
    } catch (e) {
      errorMessage = "Something went wrong. Try again!";
      print('Error: $e');
    }

    isLoading = false;
    notifyListeners();
    return false; // Login failed
  }
}
