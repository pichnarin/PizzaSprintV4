import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../env/environment.dart';
import '../../env/user_local_storage/secure_storage.dart';
import '../model/user.dart';

class UserProvider with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  User? _user;

  User? get user => _user;
  String? get error => errorMessage;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${Environment.endpointApi}/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String jwtToken =
            data['token'] ?? 'No JWT received';

        await secureLocalStorage.persistentToken(jwtToken);

        // Store user data
        _user = User.fromJson(data['data']);
        print("User login successful");
        print("User Data: ${_user!.name}, ${_user!.email}");

        final String? storedToken = await secureLocalStorage.retrieveToken();

        print('Stored token: $storedToken');
        print("User login successful");
        print("Response body: ${response.body}");


        isLoading = false;
        notifyListeners();
        return true;
      } else {
        errorMessage = "Invalid email or password";
      }
    } catch (e) {
      errorMessage = "Something went wrong. Try again!";
      print('Error: $e');
    }

    isLoading = false;
    notifyListeners();
    return false;
  }



}
