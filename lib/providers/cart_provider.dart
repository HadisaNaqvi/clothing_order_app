import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/cart.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Box<Cart> _cartBox = Hive.box<Cart>('cart');
  List<Cart> _cartItems = [];

  List<Cart> get cartItems => _cartItems;

  int get cartCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Load all cart items from Hive
  void loadCartItems() {
    _cartItems = _cartBox.values.toList();
    notifyListeners();
  }

  // Add or update a product in cart
  Future<void> addToCart(Product product, int quantity) async {
    final index = _cartItems.indexWhere((c) => c.product.id == product.id);

    if (index >= 0) {
      final updated = Cart(
        product: _cartItems[index].product,
        quantity: _cartItems[index].quantity + quantity,
      );
      await _cartBox.putAt(index, updated);
    } else {
      await _cartBox.add(Cart(product: product, quantity: quantity));
    }
    loadCartItems();
  }

  // Toggle cart: if in cart → remove, else → add
  Future<void> toggleCart(Product product) async {
    final index = _cartItems.indexWhere((c) => c.product.id == product.id);

    if (index >= 0) {
      await _cartBox.deleteAt(index);
    } else {
      await _cartBox.add(Cart(product: product, quantity: 1));
    }
    loadCartItems();
  }

  // Check if product exists in cart
  bool isInCart(Product product) =>
      _cartItems.any((c) => c.product.id == product.id);

  // Remove item by index (used in CartScreen)
  Future<void> removeFromCart(int index) async {
    if (index >= 0 && index < _cartBox.length) {
      await _cartBox.deleteAt(index);
      loadCartItems();
    }
  }

  // Clear entire cart
  Future<void> clearCart() async {
    await _cartBox.clear();
    loadCartItems();
  }

  // Calculate total cost
  double getTotal() {
    return _cartItems.fold(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }
}
