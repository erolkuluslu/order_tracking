import 'package:flutter/cupertino.dart';

import '../model/model.dart';
import '../model/order.dart';

abstract class OrderService {
  void addOrder(Order order);
  void updateOrder(String orderId, OrderStatus status);
}

class OrderViewModel extends ChangeNotifier implements OrderService {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  @override
  void addOrder(Order order) {
    // Check for duplicate orderId
    if (_orders.any((existingOrder) => existingOrder.orderId == order.orderId)) {
      throw Exception('Order ID already exists');
    }
    _orders.add(order);
    notifyListeners();
  }

  @override
  void updateOrder(String orderId, OrderStatus status) {
    final order = _orders.firstWhere(
          (order) => order.orderId == orderId,
      orElse: () => throw Exception('Order not found'),
    );
    order.status = status;
    notifyListeners();
  }
}
