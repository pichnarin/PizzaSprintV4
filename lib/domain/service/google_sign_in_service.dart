import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:pizzaprint_v4/env/environment.dart';
import 'package:pizzaprint_v4/env/user_local_storage/secure_storage.dart';

class GoogleSignInService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? '412279854118-3mtqpa6434q452khva4m2hg5cbps7v01.apps.googleusercontent.com' // Web client ID
        : null, // Android client ID is automatically used from google-services.json
    scopes: <String>[
      'openid',
      'email',
      'profile',
    ],
  );

  Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          print('User cancelled the login');
          return null;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      }

      return userCredential;
    } catch (error) {
      print('Error signing in with Google: $error');
      return null;
    }
  }

  Future<void> sendIdTokenToBackend(String? idToken) async {
    if (idToken == null || idToken.isEmpty) {
      print('Error: idToken is null or empty');
      return;
    }

    try {
      final url = Uri.parse('${Environment.endpointApi}/google-login');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken', // Some backends require this
        },
        body: jsonEncode(<String, String>{
          'idToken': idToken, // Check if your backend expects a different key
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String jwtToken = data['jwtToken'] ?? 'No JWT received'; // Handle missing key

        //store the jwt_token of the user
        await secureLocalStorage.persistentToken(jwtToken);

        final String? storedToken = await secureLocalStorage.retrieveToken();

        print('Stored token: $storedToken');

        print("User signup successful");
        print("Response body: ${response.body}");

      } else {
        print('Failed to authenticate with backend. Status Code: ${response.statusCode}');
        print('Response body: ${response.body}'); // Print response for debugging
      }
    } catch (e) {
      print('Error sending idToken to backend: $e');
    }
  }
}