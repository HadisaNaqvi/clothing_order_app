import 'package:flutter/foundation.dart';
import '../models/product.dart';

class WishlistProvider with ChangeNotifier {
  final List<Product> _wishlist = [];

  List<Product> get wishlist => List.unmodifiable(_wishlist);

  bool isInWishlist(Product product) =>
      _wishlist.any((item) => item.id == product.id);

  void toggleWishlist(Product product) {
    final alreadyIn = isInWishlist(product);
    if (alreadyIn) {
      _wishlist.removeWhere((item) => item.id == product.id);
    } else {
      _wishlist.add(product);
    }
    notifyListeners();
  }
}
