import 'dart:convert';
import 'package:pizzaprint_v4/domain/model/categories.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class CategoryService {

  Future<List<Category>> fetchCategories() async {
    try {
      http.Response response = await apiService.get('categories');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        return jsonData.map((food) => Category.fromJson(food)).toList();
      } else {
        throw Exception('Failed to fetch categories: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

