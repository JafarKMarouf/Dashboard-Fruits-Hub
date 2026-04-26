import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/features/orders/presentation/cubit/orders_cubit/orders_state.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';

class OrdersFilterBar extends StatelessWidget {
  final OrderFilter activeFilter;
  final Map<OrderFilter, int> counts;
  final ValueChanged<OrderFilter> onFilterChanged;

  const OrdersFilterBar({
    super.key,
    required this.activeFilter,
    required this.counts,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: OrderFilter.values.map((filter) {
          final isActive = filter == activeFilter;
          final count = counts[filter] ?? 0;
          return GestureDetector(
            onTap: () => onFilterChanged(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.green1_600 : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextWidget(
                    filter.labelAr,
                    style: AppTextStyles.styleSemiBold13.copyWith(
                      color: isActive ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                  if (count > 0 && filter != OrderFilter.all) ...[
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.white.withOpacity(0.3)
                            : AppColors.grayscale200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AppTextWidget(
                        '$count',
                        style: AppTextStyles.styleBold11.copyWith(
                          color: isActive
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
