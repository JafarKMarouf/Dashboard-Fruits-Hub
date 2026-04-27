import 'package:dashboard_fruit_hub/features/dashboard/presentation/cubit/dashboard_order_cubit/dashboard_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'animated_order_item.dart';

class RecentOrdersSliverList extends StatelessWidget {
  final AnimationController entryController;

  const RecentOrdersSliverList({super.key, required this.entryController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardOrderCubit, DashboardOrderState>(
      builder: (context, state) {
        if (state is DashboardOrderLoading) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is DashboardOrderFailure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Text('Error: ${state.message}')),
            ),
          );
        }

        if (state is DashboardOrderLoaded) {
          final orders = state.orders;

          if (orders.isEmpty) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('No recent orders found.')),
            );
          }

          return DecoratedSliver(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            sliver: SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final isLast = index == orders.length - 1;
                  return Column(
                    children: [
                      AnimatedOrderItem(
                        key: ValueKey(orders[index].id),
                        order: orders[index],
                        entryController: entryController,
                        delayFraction: (0.55 + index * 0.08).clamp(0.0, 0.90),
                      ),
                      if (!isLast)
                        const Divider(
                          height: 2,
                          indent: 16,
                          endIndent: 16,
                          color: Color(0xFFF3F4F6),
                        ),
                    ],
                  );
                }, childCount: orders.length),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
