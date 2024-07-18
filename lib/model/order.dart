import 'model.dart';

class FoodItem {
  final String foodName;
  final int foodCount;

  FoodItem({required this.foodName, required this.foodCount});
}

class Order {
  final String orderId;
  final String customerName;
  final List<FoodItem> foodItems;
  OrderStatus _status; // Private field

  Order({required this.orderId, required this.customerName, required this.foodItems, required OrderStatus status}) : _status = status;

  OrderStatus get status => _status;
  set status(OrderStatus status) {
    _status = status;
  }

  void updateStatus(OrderStatus newStatus) {
    _status = newStatus;
  }
}
