import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/app_text_styles.dart';

class EmptyView extends StatelessWidget {
  final String emptyMessage;
  const EmptyView({super.key, required this.emptyMessage});

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
        AppTextWidget(
          emptyMessage,
          style: AppTextStyles.styleSemiBold16.copyWith(
            color: AppColors.textSecondary,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
