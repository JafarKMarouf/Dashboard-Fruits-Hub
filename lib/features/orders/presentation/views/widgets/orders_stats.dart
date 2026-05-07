import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/order_status.dart';
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
          return const Padding(
            padding: EdgeInsets.only(top: 12),
            child: OrdersStatsRow(total: 0, pending: 0, shipped: 0, revenue: 0),
          );
        }

        final cubit = context.read<OrdersCubit>();
        final revenue = state.all
            .where(
              (order) =>
                  order.status != OrderStatus.cancelled &&
                  order.status != OrderStatus.pending,
            )
            .fold<double>(0.0, (sum, order) => sum + order.finalTotal);

        final totalInLastTwoDays = state.all.where((order) {
          final now = DateTime.now();
          final twoDaysAgo = now.subtract(const Duration(days: 2));
          return order.createdAt!.isAfter(twoDaysAgo);
        }).length;
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: OrdersStatsRow(
            total: totalInLastTwoDays,
            pending: cubit.countByStatus(OrderStatus.pending),
            shipped: cubit.countByStatus(OrderStatus.shipped),
            revenue: revenue,
          ),
        );
      },
    );
  }
}
