import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_text_styles.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget('نظرة عامة', style: AppTextStyles.styleBold28),
        SizedBox(height: 2),
        AppTextWidget(
          'إليك ما يحدث في متجرك اليوم',
          style: AppTextStyles.styleBold14,
        ),
      ],
    );
  }
}
