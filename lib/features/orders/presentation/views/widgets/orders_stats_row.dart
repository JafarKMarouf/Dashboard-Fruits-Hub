import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/utils/helpers/format_revenue.dart';

class OrdersStatsRow extends StatelessWidget {
  final int total;
  final int pending;
  final int shipped;
  final double revenue;

  const OrdersStatsRow({
    super.key,
    required this.total,
    required this.pending,
    required this.shipped,
    required this.revenue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          label: 'الطلبات الجديدة',
          value: '$total',
          sub: 'في آخر ١٢٠ دقيقة',
          bg: const Color(0xffd5f5e1).withOpacity(.5),
          fg: AppColors.green1_600,
          icon: Icons.shopping_bag_rounded,
          isAccent: true,
        ),
        const SizedBox(width: 12),
        _StatCard(
          label: 'المبيعات',
          value: formatRevenue(revenue),
          sub: '(إجمالي/اليوم) ل.س',
          bg: Colors.white,
          fg: const Color(0xFF6a798f),
          icon: Icons.attach_money_rounded,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final Color bg;
  final Color fg;
  final IconData icon;
  final bool isAccent;

  const _StatCard({
    required this.label,
    required this.value,
    required this.sub,
    required this.bg,
    required this.fg,
    required this.icon,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          border: isAccent
              ? Border.all(color: AppColors.green1_600, width: 1)
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: fg.withOpacity(0.8)),
                const SizedBox(width: 4),
                AppTextWidget(
                  label,
                  style: AppTextStyles.styleSemiBold13.copyWith(
                    color: fg.withOpacity(0.85),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            AppTextWidget(value, style: AppTextStyles.styleBold23, maxLines: 2),
            const SizedBox(height: 2),
            AppTextWidget(
              sub,
              style: AppTextStyles.styleSemiBold11.copyWith(
                color: fg.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
