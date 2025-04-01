

import 'package:flutter/foundation.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';
import 'package:pizzaprint_v4/domain/service/food_service.dart';

class FoodProvider with ChangeNotifier {
  final FoodService _foodService = FoodService();
  List<Food> _foods = [];
  List<Food> _filteredFoods = [];
  bool _isLoading = false;
  String _error = '';

  List<Food> get foods => _foods;
  List<Food> get filteredFoods => _filteredFoods;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchAllFoods() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _foods = await _foodService.fetchAllFoods();
      _filteredFoods = _foods;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getFoodByCategory(String categoryId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _filteredFoods = await _foodService.getFoodByCategory(categoryId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterFoodsBySearch(String query) {
    if (query.isEmpty) {
      _filteredFoods = _foods;
    } else {
      _filteredFoods = _foods
          .where((food) =>
              food.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

