import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/order_entity/order_entity.dart';
import '../../../../../core/utils/shared/widgets/custom_error_widget.dart';
import '../../cubit/orders_cubit/orders_cubit.dart';
import '../../cubit/orders_cubit/orders_state.dart';
import 'empty_orders.dart';
import 'order_card.dart';
import 'orders_list_loading.dart';

class OrdersList extends StatelessWidget {
  final ValueChanged<OrderEntity> onOrderTap;

  const OrdersList({super.key, required this.onOrderTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        // ── Loading ────────────────────────────────────────────────────────
        if (state is OrdersInitialState || state is OrdersLoadingState) {
          return const OrdersListLoading();
        }

        // ── Hard failure (stream error) ────────────────────────────────────
        if (state is OrdersFailureState) {
          return SliverFillRemaining(
            child: CustomErrorWidget(
              errorMessage: state.message,
              onRetry: () => context.read<OrdersCubit>().startWatching(),
            ),
          );
        }

        // ── Resolve displayed orders + updating id ─────────────────────────
        final (orders, updatingId) = switch (state) {
          OrdersLoadedState() => (state.filtered, state.updatingOrderId),
          _ => (<OrderEntity>[], null),
        };

        // ── Empty ──────────────────────────────────────────────────────────
        if (orders.isEmpty) {
          return const SliverFillRemaining(child: EmptyOrders());
        }

        // ── List ───────────────────────────────────────────────────────────
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final order = orders[index];
            return OrderCard(
              key: ValueKey(order.id),
              order: order,
              isUpdating: updatingId == order.id,
              onTap: () => onOrderTap(order),
              onStatusChanged: (status) => context
                  .read<OrdersCubit>()
                  .updateStatus(orderId: order.id!, status: status),
            );
          }, childCount: orders.length),
        );
      },
    );
  }
}
