import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String changePercent;
  final bool isPositive;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.changePercent,
    required this.isPositive,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppTextWidget(
                  title,
                  style: AppTextStyles.styleSemiBold13,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppTextWidget(value, style: AppTextStyles.styleBold28),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                isPositive
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                size: 16,
                color: isPositive ? AppColors.success : AppColors.error,
              ),
              AppTextWidget(
                changePercent,
                style: AppTextStyles.styleBold13.copyWith(
                  color: isPositive ? AppColors.success : AppColors.error,
                ),
              ),
              const SizedBox(width: 4),

              AppTextWidget(
                'من الأسبوع الماضي',
                style: AppTextStyles.styleBold11.copyWith(
                  color: AppColors.primary.withOpacity(.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
