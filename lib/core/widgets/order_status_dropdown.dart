import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/model.dart';

class OrderStatusDropdown extends StatelessWidget {
  final OrderStatus currentStatus;
  final ValueChanged<OrderStatus> onStatusChanged;

  const OrderStatusDropdown({super.key,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<OrderStatus>(
      value: currentStatus,
      decoration: const InputDecoration(labelText: 'Status'),
      items: OrderStatus.values.map((OrderStatus status) {
        return DropdownMenuItem<OrderStatus>(
          value: status,
          child: Text(status.toString().split('.').last),
        );
      }).toList(),
      onChanged: (value) {
        onStatusChanged(value!);
      },
    );
  }
}
