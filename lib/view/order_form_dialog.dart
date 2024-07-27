
part of '../../view/order_tile.dart';

class OrderFormDialog extends StatefulWidget {
  final Order order;

  const OrderFormDialog({super.key, required this.order});

  @override
  _OrderFormDialogState createState() => _OrderFormDialogState();
}

class _OrderFormDialogState extends State<OrderFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _orderId;
  late List<FoodItem> _foodItems;
  late OrderStatus _status;

  @override
  void initState() {
    super.initState();
    _orderId = widget.order.orderId;
    _foodItems = List.from(widget.order.foodItems); // Copying the list of food items
    _status = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Order'),
      content: Form(
        key: _formKey,
        child: OrderFormContent(
          orderId: _orderId,
          foodItems: _foodItems,
          status: _status,
          onStatusChanged: (newStatus) {
            setState(() {
              _status = newStatus;
            });
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Provider.of<OrderViewModel>(context, listen: false).updateOrder(_orderId, _status);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
