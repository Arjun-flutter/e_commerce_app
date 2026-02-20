import 'package:ecommer_app/models/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Map<int, int> _cartItems = {};

  Map<int, int> get cartItems => _cartItems;

   // Add items to cart

  void addToCart(Product product) {
    final productId = product.id;
    _cartItems.update(productId, (v) => v + 1, ifAbsent: () => 1);

    notifyListeners();
  }
   // Remove one qty from cart

  void removeOne(Product product) {
    final productId = product.id;
    if (!_cartItems.containsKey(productId)) return;

    if (_cartItems[productId]! > 1) {
      _cartItems.update(productId, (qty) => qty - 1);
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  // remove item from cart

  void removeItem(Product product) {
    _cartItems.remove(product.id);
    notifyListeners();
  }

// clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Total quantity
  int get totalItems => _cartItems.values.fold(0, (sum, qty) => sum + qty);

  // total price

  double getTotalPrice(List<Product> products) {
    double total = 0;
    for (var entry in _cartItems.entries) {
      final product = products.firstWhere((p) => p.id == entry.key, orElse: () => products.first);

      total += product.price * entry.value;
    }
    return total;
  }
}
