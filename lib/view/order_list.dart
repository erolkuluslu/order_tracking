
part of '../../view/order_tile.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderViewModel>(
      builder: (context, orderViewModel, child) {
        return ListView.builder(
          itemCount: orderViewModel.orders.length,
          itemBuilder: (context, index) {
            final order = orderViewModel.orders[index];
            return OrderTile(order: order);
          },
        );
      },
    );
  }
}
