import 'package:flutter/cupertino.dart';

import '../../model/model.dart';
import '../../model/order.dart';
import 'order_status_dropdown.dart';

class OrderFormContent extends StatelessWidget {
  final String orderId;
  final List<FoodItem> foodItems;
  final OrderStatus status;
  final ValueChanged<OrderStatus> onStatusChanged;

  const OrderFormContent({
    super.key,
    required this.orderId,
    required this.foodItems,
    required this.status,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Ordered food ID is: $orderId"),
        const SizedBox(height: 10),
        const Text("Ordered food items:"),
        ...foodItems
            .map((item) => Text('${item.foodCount} x ${item.foodName}'))
            .toList(),
        OrderStatusDropdown(
          currentStatus: status,
          onStatusChanged: onStatusChanged,
        ),
      ],
    );
  }
}
