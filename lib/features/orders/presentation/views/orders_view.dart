import 'package:flutter/material.dart';

import 'widgets/order_view_body.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  static const routeName = 'orders-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: OrdersViewBody());
  }
}
