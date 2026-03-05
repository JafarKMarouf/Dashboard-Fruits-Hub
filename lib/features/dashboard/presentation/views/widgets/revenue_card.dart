import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';

class RevenueCard extends StatelessWidget {
  const RevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
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
                    child: const Icon(Icons.wallet, color: AppColors.primary),
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

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_upward_rounded,
                      size: 12,
                      color: AppColors.primaryDark,
                    ),
                    const SizedBox(width: 2),
                    AppTextWidget(
                      '12%+',
                      style: AppTextStyles.styleBold13.copyWith(
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AppTextWidget('\$12,450', style: AppTextStyles.styleBold28),
        ],
      ),
    );
  }
}
