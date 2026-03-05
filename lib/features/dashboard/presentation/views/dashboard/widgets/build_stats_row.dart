import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import 'stats_card.dart';

class BuildStatsRow extends StatelessWidget {
  const BuildStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatsCard(
            title: 'الطلبات',
            value: '342',
            changePercent: '5%',
            isPositive: false,
            icon: Icons.shopping_bag_rounded,
            iconBgColor: AppColors.secondaryLight.withOpacity(.2),
            iconColor: AppColors.secondary,
          ),
        ),

        const SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            title: 'المستخدمون الجدد',
            value: '56',
            changePercent: '8%',
            isPositive: false,
            icon: Icons.group_add_rounded,
            iconBgColor: AppColors.primaryLight.withOpacity(.3),
            iconColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
