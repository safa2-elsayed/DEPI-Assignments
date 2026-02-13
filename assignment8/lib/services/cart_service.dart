import 'package:assignment7/models/food_model.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final Map<String, int> _cartItems = {};

  void addToCart(String foodId) {
    if (_cartItems.containsKey(foodId)) {
      _cartItems[foodId] = _cartItems[foodId]! + 1;
    } else {
      _cartItems[foodId] = 1;
    }
  }

  void removeFromCart(String foodId) {
    if (_cartItems.containsKey(foodId) && _cartItems[foodId]! > 1) {
      _cartItems[foodId] = _cartItems[foodId]! - 1;
    } else {
      _cartItems.remove(foodId);
    }
  }

  Map<String, int> get items => _cartItems;

  double getTotalPrice() {
    double total = 0;
    _cartItems.forEach((key, quantity) {
      final food = FoodModel.dummyData.firstWhere(
        (element) => element.id == key,
      );
      total += (food.price * quantity);
    });
    return total;
  }
}
