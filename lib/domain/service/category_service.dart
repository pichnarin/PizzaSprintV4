import 'dart:convert';
import 'package:pizzaprint_v4/domain/model/categories.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';

import 'api_service.dart';

class CategoryService {
  // Fetch categories from the backend
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await apiService.get('categories');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  // Fetch food items by category from the backend
  Future<List<Food>> fetchFoodItems(String categoryId) async {
    try {
      final response = await apiService.get('foods/category/$categoryId');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((food) => Food.fromJson(food)).toList();
      } else {
        throw Exception('Failed to load food items');
      }
    } catch (e) {
      print('Error fetching food items: $e');
      return [];
    }
  }
}

