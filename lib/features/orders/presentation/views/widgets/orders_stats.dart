import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/order_entity/order_status.dart';
import '../../cubit/orders_cubit/orders_cubit.dart';
import '../../cubit/orders_cubit/orders_state.dart';
import 'orders_stats_row.dart';

class OrdersStats extends StatelessWidget {
  const OrdersStats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      buildWhen: (_, curr) => curr is OrdersLoadedState,
      builder: (context, state) {
        if (state is! OrdersLoadedState) {
          return const OrdersStatsRow(
            total: 0,
            pending: 0,
            shipped: 0,
            revenue: 0,
          );
        }
        final cubit = context.read<OrdersCubit>();
        final revenue = state.orders
            .where((o) => o.status != OrderStatus.cancelled)
            .fold<double>(0, (s, o) => s + o.finalTotal);
        // final revenue = state.orders.fold<double>(
        //   0,
        //   (s, o) => s + o.finalTotal,
        // );
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: OrdersStatsRow(
            total: state.orders.length,
            pending: cubit.countByStatus(OrderStatus.pending),
            shipped: cubit.countByStatus(OrderStatus.shipped),
            revenue: revenue,
          ),
        );
      },
    );
  }
}
