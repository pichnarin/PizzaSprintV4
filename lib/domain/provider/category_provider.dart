import 'package:flutter/material.dart';
import 'package:pizzaprint_v4/domain/model/categories.dart';
import 'package:pizzaprint_v4/domain/service/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();

  List<Category> _categories = [];
  bool _isLoading = false;
  String _error = '';

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final fetchedCategories = await _categoryService.fetchCategories();
      _categories = fetchedCategories;
    } catch (e) {
      _error = 'Error fetching categories: ${e.toString()}';
      _categories = []; // Ensure old data is cleared
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
