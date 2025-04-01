import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/addresses.dart';
import 'api_service.dart';

class LocationService{
  Future<List<Addresses>> fetchAllAddress() async {
    try {
      http.Response response = await apiService.get('addresses/fetch-addresses');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((address) => Addresses.fromJson(address)).toList();
      } else {
        throw Exception('Failed to fetch foods: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> createAddress(Addresses address) async {
    try {
      http.Response response = await apiService.post('/addresses/create-address', address.toJson());

      if (response.statusCode == 201) {
        response.body;
      } else {
        throw Exception('Failed to create address: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

