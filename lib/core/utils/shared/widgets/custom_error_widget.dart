import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_text_styles.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
            'حدث خطأ: $errorMessage',
            style: AppTextStyles.styleSemiBold16.copyWith(
              color: AppColors.error,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          TextButton.icon(
            onPressed: () => onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 20),
            label: const AppTextWidget(
              'إعادة المحاولة',
              style: AppTextStyles.styleBold13,
            ),
          ),
        ],
      ),
    );
  }
}
