import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  Box<Product>? _productBox;
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> loadProducts() async {
    _productBox ??= await Hive.openBox<Product>('products');
    _products = _productBox!.values.toList();
    notifyListeners();
  }
}
