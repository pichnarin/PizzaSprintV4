import 'dart:convert';

// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as http;
import 'package:http/http.dart' as http;
import 'package:pizzaprint_v4/domain/model/track.dart';
import 'api_service.dart';

class TrackService {

  Future<List<DriverTracking>> fetchDriverLocation(int orderId) async{
    try {
      http.Response response = await apiService.get('driverTracking/fetch-driver-tracking/$orderId');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        print('Fetched foods: $jsonData');
        return jsonData.map((food) => DriverTracking.fromJson(food)).toList();
      } else {
        throw Exception('Failed to fetch foods: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }




  Future<Map<String, dynamic>> fetchCustomerDriverLocation(int orderId) async {
    try {
      http.Response response = await apiService.get('driverTracking/fetch-driver-tracking/$orderId');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body)['data'];
        print('Fetched Tracking Location: $jsonData');
        return jsonData;
      } else {
        throw Exception('Failed to fetch location: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchDriverCustomerLocation(int orderId) async {
    try {
      http.Response response = await apiService.get('driverTracking/fetch-customer-tracking/$orderId');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body)['data'];
        print('Fetched Tracking Location: $jsonData');
        return jsonData;
      } else {
        throw Exception('Failed to fetch location: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }




}