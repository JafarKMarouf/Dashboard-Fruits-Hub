import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/shared/widgets/app_text_widget.dart';
import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/entities/order_entity/order_entity.dart';
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
        // ── Loading ──────────────────────────────────────────────────────────
        if (state is OrdersInitial || state is OrdersLoading) {
          return const OrdersListLoading();
        }

        // ── Error ────────────────────────────────────────────────────────────
        if (state is OrdersError) {
          return _OrdersErrorSliver(message: state.message);
        }

        // ── Resolve orders + updating id ─────────────────────────────────────
        final (orders, updatingId) = switch (state) {
          OrdersLoaded() => (state.filtered, state.updatingOrderId),
          OrderStatusUpdateError() => (state.filtered, null),
          _ => (<OrderEntity>[], null),
        };

        // ── Empty ────────────────────────────────────────────────────────────
        if (orders.isEmpty) {
          return const SliverFillRemaining(child: EmptyOrders());
        }

        // ── List ─────────────────────────────────────────────────────────────
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

// ─────────────────────────────────────────────────────────────────────────────
// _OrdersErrorSliver — private, only used by OrdersList
// ─────────────────────────────────────────────────────────────────────────────

class _OrdersErrorSliver extends StatelessWidget {
  final String message;

  const _OrdersErrorSliver({required this.message});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 12),
            AppTextWidget(
              'حدث خطأ: $message',
              style: AppTextStyles.styleRegular16.copyWith(
                color: AppColors.error,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => context.read<OrdersCubit>().startWatching(),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}
