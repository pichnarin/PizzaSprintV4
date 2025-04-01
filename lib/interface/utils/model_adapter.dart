
import 'package:pizzaprint_v4/domain/model/categories.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';

/// This utility class helps transition from the old Product model to the new Food model
class ModelAdapter {
  /// Convert a Food object to work with components expecting the old Product model structure
  static double getPriceForSize(Food food, String size) {
    // Since the new model only has a single price, we'll use that as the base
    // and add a modifier based on size for backward compatibility
    switch (size) {
      case 'S':
        return food.price * 0.8; // 20% less for small
      case 'L':
        return food.price * 1.2; // 20% more for large
      case 'M':
      default:
        return food.price;
    }
  }
  
  /// Get image URL from the Food model
  static String getImageUrl(Food food) {
    return food.image;
  }
  
  /// Get category name from a Category object
  static String getCategoryName(Category category) {
    return category.name;
  }
}

