import 'package:flutter/foundation.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';

class CartItem {
  final Food food;
  final String size;
  int quantity;

  CartItem({required this.food, required this.size, required this.quantity});
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};
  final Map<int, int> _items = {}; // key: foodId (int), value: quantity

  // Getters
  Map<String, CartItem> get cartItems => _cartItems;
  Map<int, int> get items => _items;

  List<CartItem> get cartItemsList => _cartItems.values.toList();

  int get itemCount => _cartItems.length;

  int get cartItemCount {
    return _cartItems.values.fold(0, (sum, item) => sum + item.quantity);
  }

  void addToCart(Food food, String size, int quantity) {
    try {
      final String cartItemId = '${food.id}_$size';

      if (_cartItems.containsKey(cartItemId)) {
        _cartItems.update(
          cartItemId,
          (existingItem) => CartItem(
            food: existingItem.food,
            size: existingItem.size,
            quantity: existingItem.quantity + quantity,
          ),
        );
      } else {
        _cartItems.putIfAbsent(
          cartItemId,
          () => CartItem(food: food, size: size, quantity: quantity),
        );
      }

      if (_items.containsKey(food.id)) {
        _items[food.id] = _items[food.id]! + quantity;
      } else {
        _items[food.id] = quantity;
      }

      notifyListeners();
    } catch (e) {
      // Handle error
      debugPrint('Error adding to cart: $e');
    }
  }

  double get totalAmount {
    try {
      double total = 0.0;
      _cartItems.forEach((key, cartItem) {
        double price = cartItem.food.price;
        total += price * cartItem.quantity;
      });
      return total;
    } catch (e) {
      // Handle error
      debugPrint('Error calculating total amount: $e');
      return 0.0;
    }
  }

  void removeFromCart(String cartItemId) {
    try {
      if (_cartItems.containsKey(cartItemId)) {
        final parts = cartItemId.split('_');
        if (parts.isNotEmpty) {
          final foodId = int.tryParse(parts[0]);
          if (foodId != null) {
            _items.remove(foodId);
          }
        }
        _cartItems.remove(cartItemId);
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      debugPrint('Error removing from cart: $e');
    }
  }

  void removeFromCartSimple(int foodId) {
    try {
      _items.remove(foodId);
      _cartItems.removeWhere((key, item) => item.food.id == foodId);
      notifyListeners();
    } catch (e) {
      // Handle error
      debugPrint('Error removing from cart: $e');
    }
  }

  void clearCart() {
    try {
      _cartItems.clear();
      _items.clear();
      notifyListeners();
    } catch (e) {
      // Handle error
      debugPrint('Error clearing cart: $e');
    }
  }

  List<Map<String, dynamic>> getOrderData() {
    try {
      return _items.entries
          .map((entry) => {'food_id': entry.key, 'quantity': entry.value})
          .toList();
    } catch (e) {
      // Handle error
      debugPrint('Error getting order data: $e');
      return [];
    }
  }

  List<Map<String, dynamic>> getOrderDataDetailed() {
    try {
      return _cartItems.values
          .map(
            (item) => {
              'food_id': item.food.id,
              'size': item.size,
              'quantity': item.quantity,
              'price': item.food.price,
            },
          )
          .toList();
    } catch (e) {
      // Handle error
      debugPrint('Error getting detailed order data: $e');
      return [];
    }
  }

  void increaseQuantity(CartItem item) {
    try {
      final String cartItemId = '${item.food.id}_${item.size}';
      if (_cartItems.containsKey(cartItemId)) {
        _cartItems.update(
          cartItemId,
          (existingItem) => CartItem(
            food: existingItem.food,
            size: existingItem.size,
            quantity: existingItem.quantity + 1,
          ),
        );
        if (_items.containsKey(item.food.id)) {
          _items[item.food.id] = _items[item.food.id]! + 1;
        }
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      debugPrint('Error increasing quantity: $e');
    }
  }

  void decreaseQuantity(CartItem item) {
    try {
      final String cartItemId = '${item.food.id}_${item.size}';
      if (_cartItems.containsKey(cartItemId)) {
        if (_cartItems[cartItemId]!.quantity > 1) {
          _cartItems.update(
            cartItemId,
            (existingItem) => CartItem(
              food: existingItem.food,
              size: existingItem.size,
              quantity: existingItem.quantity - 1,
            ),
          );
          if (_items.containsKey(item.food.id) && _items[item.food.id]! > 1) {
            _items[item.food.id] = _items[item.food.id]! - 1;
          }
        } else {
          removeFromCart(cartItemId);
        }
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      debugPrint('Error decreasing quantity: $e');
    }
  }

  void updateQuantity(CartItem item, int quantity) {
    try {
      final String cartItemId = '${item.food.id}_${item.size}';
      if (_cartItems.containsKey(cartItemId)) {
        _cartItems.update(
          cartItemId,
          (existingItem) => CartItem(
            food: existingItem.food,
            size: existingItem.size,
            quantity: quantity,
          ),
        );
        _items[item.food.id] = quantity;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
      debugPrint('Error updating quantity: $e');
    }
  }

  void removeItem(CartItem item) {
    try {
      final String cartItemId = '${item.food.id}_${item.size}';
      removeFromCart(cartItemId);
    } catch (e) {
      // Handle error
      debugPrint('Error removing item: $e');
    }
  }
}
