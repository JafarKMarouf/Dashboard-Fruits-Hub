import 'package:flutter/material.dart';

import '../../../../../../core/utils/shared/widgets/app_text_widget.dart';
import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';

class BuildRecentOrdersHeader extends StatelessWidget {
  const BuildRecentOrdersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .end,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            const AppTextWidget(
              'الطلبات الأخيرة',
              style: AppTextStyles.styleBold16,
            ),
            TextButton(
              onPressed: () {},
              child: AppTextWidget(
                'عرض الكل',
                style: AppTextStyles.styleBold13.copyWith(
                  color: AppColors.green1_600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
