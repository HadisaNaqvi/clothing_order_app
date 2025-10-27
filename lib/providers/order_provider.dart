import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  Box<Order>? _orderBox;
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  // Initialize Hive box properly
  Future<void> loadOrders() async {
    _orderBox ??= await Hive.openBox<Order>('orders');
    _orders = _orderBox!.values.toList();
    notifyListeners();
  }

  Future<void> addOrder(Order order) async {
    _orderBox ??= await Hive.openBox<Order>('orders');
    await _orderBox!.put(order.id, order);
    await loadOrders();
  }

  Future<void> deleteOrder(String id) async {
    _orderBox ??= await Hive.openBox<Order>('orders');
    await _orderBox!.delete(id);
    await loadOrders();
  }

  Future<void> clearOrders() async {
    _orderBox ??= await Hive.openBox<Order>('orders');
    await _orderBox!.clear();
    await loadOrders();
  }
}
