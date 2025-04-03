import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pizzaprint_v4/env/environment.dart';

import '../model/addresses.dart';
import 'api_service.dart';

class LocationService {

  Future<List<Addresses>> fetchAllAddress() async {
    try {
      http.Response response = await apiService.get(
          'addresses/fetch-addresses');

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

  /// Helper function to extract values safely
  String _getContextValue(List<dynamic> context, String key) {
    print("Context: $context");
    return context.firstWhere((c) => c["id"].startsWith(key),
        orElse: () => {"text": ""})["text"];
  }

  //get address by coordinate lat and long
  Future<Map<String, dynamic>?> fetchAddressByCoordinate(double latitude,
      double longitude) async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=${Environment
                  .mapboxApiKey}"
          )
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
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
          };
        }
      }
    } catch (e) {
      throw("❌ Error fetching address from Mapbox: $e");
    }
    return null;
  }

  Future<void> createAddress(Addresses address) async {
    try {
      http.Response response = await apiService.post(
        'addresses/create-address',
        address.toJson(),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Handle success, like returning the created address or something else
      } else {
        throw Exception('Failed to create address: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}

final LocationService locationService = LocationService();


class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final LocationService _locationService = LocationService();
  String _address = '';

  Future<void> _fetchAddress() async {
    try {
      final result = await _locationService.fetchAddressByCoordinate(
          40.7128, -74.0060);
      setState(() {
        _address = result != null ? result.toString() : 'No address found';
      });
    } catch (e) {
      setState(() {
        _address = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _fetchAddress,
              child: Text('Fetch Address'),
            ),
            SizedBox(height: 20),
            Text('Address: $_address'),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TestScreen(),
  ));
}


