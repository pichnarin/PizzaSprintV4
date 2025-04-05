import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pizzaprint_v4/env/environment.dart';
import '../model/addresses.dart';
import 'api_service.dart';

class LocationService {
  Future<List<Addresses>> fetchAllAddress() async {
    try {
      http.Response response = await apiService.get('addresses/fetch-addresses');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((address) => Addresses.fromJson(address)).toList();
      } else {
        throw Exception('Failed to fetch addresses: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  /// Helper to safely extract from Mapbox context
  String _getContextValue(List<dynamic> context, String key) {
    try {
      return context.firstWhere((c) => c["id"].toString().startsWith(key),
          orElse: () => {"text": ""})["text"];
    } catch (e) {
      return "";
    }
  }

  Future<Map<String, dynamic>?> fetchAddressByCoordinate(
      double latitude, double longitude) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=${Environment.mapboxApiKey}"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["features"].isNotEmpty) {
          var place = data["features"][0];
          var context = place["context"] ?? [];

          return {
            "latitude": latitude,
            "longitude": longitude,
            "city": _getContextValue(context, "place"),
            "state": _getContextValue(context, "region"),
            "zip": _getContextValue(context, "postcode"),
            "reference": place["text"] ?? "",
            "place_name": place["place_name"] ?? ""
          };
        }
      }
    } catch (e) {
      throw ("❌ Error fetching address from Mapbox: $e");
    }
    return null;
  }

  Future<void> createAddress(Addresses address) async {
    try {
      http.Response response = await apiService.post(
        'addresses/create-address',
        address.toJson(),
      );

      if (response.statusCode == 201) {
        debugPrint('✅ Address created successfully');
      } else {
        throw Exception('Failed to create address: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

// Singleton instance
final LocationService locationService = LocationService();
