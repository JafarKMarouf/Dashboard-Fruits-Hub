import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/features/dashboard/presentation/cubit/dashboard_order_cubit/dashboard_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/utils/helpers/format_revenue.dart';
import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';

class RevenueCard extends StatelessWidget {
  const RevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardOrderCubit, DashboardOrderState>(
      builder: (context, state) {
        final isLoading =
            state is DashboardOrderLoading || state is DashboardOrderInitial;
        final revenue = state is DashboardOrderLoaded
            ? state.totalRevenue
            : 0.0;
        final activeCount = state is DashboardOrderLoaded
            ? state.activeOrdersCount
            : 0;
        final pendingCount = state is DashboardOrderLoaded
            ? state.pendingCount
            : 0;

        return Skeletonizer(
          enabled: isLoading,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.wallet,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AppTextWidget(
                          'إجمالي الإيرادات',
                          style: AppTextStyles.styleBold13.copyWith(
                            color: AppColors.grayscale500,
                          ),
                        ),
                      ],
                    ),
                    if (!isLoading && pendingCount > 0)
                      _PendingBadge(count: pendingCount),
                  ],
                ),
                const SizedBox(height: 16),
                AppTextWidget(
                  isLoading ? '---' : formatRevenue(revenue),
                  style: AppTextStyles.styleBold28,
                ),
                if (!isLoading && activeCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: AppTextWidget(
                      'من $activeCount طلب مكتمل',
                      style: AppTextStyles.styleRegular11.copyWith(
                        color: AppColors.grayscale500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PendingBadge extends StatelessWidget {
  final int count;
  const _PendingBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.hourglass_top_rounded,
            size: 12,
            color: AppColors.orange900,
          ),
          const SizedBox(width: 4),
          AppTextWidget(
            '$count قيد الانتظار',
            style: AppTextStyles.styleBold13.copyWith(
              color: AppColors.orange900,
            ),
          ),
        ],
      ),
    );
  }
}
