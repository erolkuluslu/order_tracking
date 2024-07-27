import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracking/bloc/auth_bloc.dart';
import 'package:order_tracking/view/login_Screen.dart';
import 'package:order_tracking/view/order_tile.dart';
import 'package:provider/provider.dart';
import 'core/widgets/add_order_form_widget.dart';
import 'view_model/order_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => OrderViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}

class OrderTrackingHome extends StatelessWidget {
  const OrderTrackingHome({super.key});

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
            builder: (context) => const AddOrderForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
