import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../env/environment.dart';
import '../../env/user_local_storage/secure_storage.dart';

class ApiService {

  static const String baseApiUrl = Environment.endpointApi;

  Future <http.Response> get(String endpoint) async {
    String? token = await secureLocalStorage.retrieveToken();
    print(token);
    if (token == null || token.isEmpty) {
      return http.Response('{"error": "Token is missing or invalid"}', 401);
    }

    return await http.get(
        Uri.parse('$baseApiUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        }
    );
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    String? token = await secureLocalStorage.retrieveToken();
    if (token == null || token.isEmpty) {
      throw http.Response('{"error": "Token is missing or invalid"}', 401);
    }

    return await http.post(
      Uri.parse('$baseApiUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    String? token = await secureLocalStorage.retrieveToken();
    if (token == null || token.isEmpty) {
      throw http.Response('{"error": "Token is missing or invalid"}', 401);
    }

    return await http.put(
      Uri.parse('$baseApiUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode(data),
    );
  }
}


final ApiService apiService = ApiService();