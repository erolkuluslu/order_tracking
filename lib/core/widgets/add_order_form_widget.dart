import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../model/model.dart';
import '../../model/order.dart';
import '../../view_model/order_view_model.dart';

class AddOrderForm extends StatefulWidget {
  @override
  _AddOrderFormState createState() => _AddOrderFormState();
}

class _AddOrderFormState extends State<AddOrderForm> {
  final _formKey = GlobalKey<FormState>();
  late String _customerName;
  List<FoodItem> _foodItems = [];
  late String _selectedFoodName = 'Salad';
  int _foodCount = 1;

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getNameOfOrder(),
              const SizedBox(height: 10),
              const Text('Select Food:'),
              buildFoodChoiceChips(),
              const SizedBox(height: 20),
              const Text('Food Count:'),
              buildFoodCounter(),
              const SizedBox(height: 20),
              // Display added food items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current Basket:', style: TextStyle(fontWeight: FontWeight.bold)),
                  if (_foodItems.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    buildBasket(),
                  ],
                  if (_foodItems.isEmpty) ...[
                    const SizedBox()
                  ],
                  buildButtons(orderViewModel),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(OrderViewModel orderViewModel) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _foodItems.add(FoodItem(foodName: _selectedFoodName, foodCount: _foodCount));
              _foodCount = 1;
            });
          },
          child: const Text('Add Food Item'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              int newOrderId = orderViewModel.orders.length;
              try {
                orderViewModel.addOrder(Order(
                  orderId: newOrderId.toString(),
                  customerName: _customerName,
                  foodItems: _foodItems,
                  status: OrderStatus.Pending,
                ));
                // Reset the form for the next order
                _formKey.currentState!.reset();
                setState(() {
                  _selectedFoodName = 'Salad';
                  _foodCount = 1;
                  _foodItems = [];
                });
              } catch (e) {
                // Handle error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            }
          },
          child: const Text('Add Order'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget buildBasket() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _foodItems.map((item) => Text('${item.foodCount} x ${item.foodName}')).toList(),
      ),
    );
  }

  TextFormField getNameOfOrder() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Customer Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a customer name';
        }
        return null;
      },
      onSaved: (value) {
        _customerName = value!;
      },
    );
  }

  Widget buildFoodCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (_foodCount > 1) {
              setState(() {
                _foodCount--;
              });
            }
          },
        ),
        Text('$_foodCount'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              _foodCount++;
            });
          },
        ),
      ],
    );
  }

  Widget buildFoodChoiceChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildChoiceChip('Salad'),
        _buildChoiceChip('Pizza'),
        _buildChoiceChip('Kebab'),
      ],
    );
  }

  Widget _buildChoiceChip(String foodName) {
    return ChoiceChip(
      label: Text(foodName),
      selected: _selectedFoodName == foodName,
      onSelected: (selected) {
        setState(() {
          _selectedFoodName = foodName;
        });
      },
    );
  }
}
