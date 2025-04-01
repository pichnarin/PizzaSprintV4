// import 'package:flutter/foundation.dart';

// class CartProvider with ChangeNotifier {
//   final Map<int, int> _items = {}; // key: foodId (int), value: quantity

//   Map<int, int> get items => _items;

//   void addToCart(int foodId) {
//     if (_items.containsKey(foodId)) {
//       _items[foodId] = _items[foodId]! + 1;
//     } else {
//       _items[foodId] = 1;
//     }
//     notifyListeners();
//   }

//   void removeFromCart(int foodId) {
//     _items.remove(foodId);
//     notifyListeners();
//   }


//   void clearCart() {
//     _items.clear();
//     notifyListeners();
//   }

//   List<Map<String, dynamic>> getOrderData() {
//     return _items.entries
//         .map((entry) => {
//       'food_id': entry.key,     // int type
//       'quantity': entry.value,
//     })
//         .toList();
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:pizzaprint_v4/domain/model/food.dart';

class CartItem {
  final Food food;
  final String size;
  final int quantity;

  CartItem({
    required this.food,
    required this.size,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};
  final Map<int, int> _items = {}; // key: foodId (int), value: quantity

  // Getters
  Map<String, CartItem> get cartItems => _cartItems;
  Map<int, int> get items => _items;

  List<CartItem> get cartItemsList => _cartItems.values.toList();

  int get itemCount => _cartItems.length;

  // ✅ Added missing getter
  int get cartItemCount {
    return _cartItems.values.fold(0, (sum, item) => sum + item.quantity);
  }

  void addToCart(Food food, String size, int quantity) {
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
        () => CartItem(
          food: food,
          size: size,
          quantity: quantity,
        ),
      );
    }

    if (_items.containsKey(food.id)) {
      _items[food.id] = _items[food.id]! + quantity;
    } else {
      _items[food.id] = quantity;
    }

    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, cartItem) {
      double price = cartItem.food.price;
      total += price * cartItem.quantity;
    });
    return total;
  }

  void removeFromCart(String cartItemId) {
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
  }

  void removeFromCartSimple(int foodId) {
    _items.remove(foodId);
    _cartItems.removeWhere((key, item) => item.food.id == foodId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _items.clear();
    notifyListeners();
  }

  List<Map<String, dynamic>> getOrderData() {
    return _items.entries
        .map((entry) => {
              'food_id': entry.key,
              'quantity': entry.value,
            })
        .toList();
  }

  List<Map<String, dynamic>> getOrderDataDetailed() {
    return _cartItems.values
        .map((item) => {
              'food_id': item.food.id,
              'size': item.size,
              'quantity': item.quantity,
              'price': item.food.price,
            })
        .toList();
  }

  void increaseQuantity(CartItem item) {
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
  }

  void decreaseQuantity(CartItem item) {
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
  }

  void removeItem(CartItem item) {
    final String cartItemId = '${item.food.id}_${item.size}';
    removeFromCart(cartItemId);
  }
}
