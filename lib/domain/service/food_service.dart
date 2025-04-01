import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/food.dart';
import 'api_service.dart';

class FoodService {

  Future<List<Food>> fetchAllFoods() async {
    try {
      http.Response response = await apiService.get('foods');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((food) => Food.fromJson(food)).toList();
      } else {
        throw Exception('Failed to fetch foods: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  
  Future<List<Food>> getFoodByCategory(String category) async {
    try {
      http.Response response = await apiService.get('foods/category/$category');
      
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((food) => Food.fromJson(food)).toList();
      } else {
        throw Exception('Failed to fetch foods: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  
  
}
