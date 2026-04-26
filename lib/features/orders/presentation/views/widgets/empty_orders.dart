import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.inbox_rounded,
          size: 64,
          color: AppColors.grayscale300,
        ),
        const SizedBox(height: 12),
        Text(
          'لا توجد طلبات',
          style: AppTextStyles.styleSemiBold16.copyWith(
            color: AppColors.textSecondary,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
