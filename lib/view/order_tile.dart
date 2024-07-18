import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/widgets/order_form_content.dart';
import '../model/model.dart';
import '../model/order.dart';
import '../view_model/order_view_model.dart';
part  '../../view/order_form_dialog.dart';
part  '../../view/order_list.dart';


class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({super.key, required this.order});

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.Pending:
        return Colors.orange.withOpacity(0.8);
      case OrderStatus.Cooking:
        return Colors.blue.withOpacity(0.8);
      case OrderStatus.Delivering:
        return Colors.green.withOpacity(0.8);
      case OrderStatus.Cancelled:
        return Colors.red.withOpacity(0.8);
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return OrderFormDialog(order: order);
          },
        );
      },
      child: ListTile(
        tileColor: _getStatusColor(order.status),  // Use tileColor to set the background color
        title: Text(order.customerName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: order.foodItems
              .map((item) => Text('${item.foodCount} x ${item.foodName}'))
              .toList(),
        ),
        trailing: Text(order.status.toString().split('.').last),
      ),
    );
  }
}


