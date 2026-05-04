import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../manager/customer_cubit/customers_cubit.dart';

class CustomersStatsHeader extends StatelessWidget {
  const CustomersStatsHeader({super.key, required this.state});

  final CustomersLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          'إجمالي المستخدمين (${state.totalCount})',
          style: AppTextStyles.styleBold14.copyWith(
            color: AppColors.grayscale700,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: AppTextWidget(
            'عرض الكل',
            style: AppTextStyles.styleSemiBold13.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
