import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_tracking/view/order_tile.dart';
import 'package:provider/provider.dart';
import 'core/widgets/add_order_form_widget.dart';
import 'view_model/order_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => OrderViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderTrackingHome(),
    );
  }
}

class OrderTrackingHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Order Tracking'),

      ),
      body: const OrderList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddOrderForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
