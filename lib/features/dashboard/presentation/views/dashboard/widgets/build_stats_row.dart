import 'package:dashboard_fruit_hub/features/dashboard/presentation/cubit/cubit/dashboard_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import 'stats_card.dart';

class BuildStatsRow extends StatelessWidget {
  const BuildStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardOrderCubit, DashboardOrderState>(
      builder: (context, state) {
        final isLoading =
            state is DashboardOrderLoading || state is DashboardOrderInitial;
        final totalOrders = state is DashboardOrderLoaded
            ? state.totalOrdersCount
            : 0;
        final shippedCount = state is DashboardOrderLoaded
            ? state.shippedCount
            : 0;

        return Skeletonizer(
          enabled: isLoading,
          child: Row(
            children: [
              Expanded(
                child: StatsCard(
                  title: 'إجمالي الطلبات',
                  value: isLoading ? '--' : '$totalOrders',
                  icon: Icons.shopping_bag_rounded,
                  iconBgColor: AppColors.secondaryLight.withOpacity(.2),
                  iconColor: AppColors.secondary,
                  subtitle: 'جميع الطلبات',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatsCard(
                  title: 'قيد الشحن',
                  value: isLoading ? '--' : '$shippedCount',
                  icon: Icons.local_shipping_rounded,
                  iconBgColor: AppColors.primaryLight.withOpacity(.3),
                  iconColor: AppColors.primary,
                  subtitle: 'طلب جارٍ شحنه',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
