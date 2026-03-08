import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../domain/entities/order_entity.dart';

class OrderItem extends StatelessWidget {
  final OrderEntity order;

  const OrderItem({super.key, required this.order});

  Color get _statusColor {
    switch (order.status) {
      case OrderStatus.pending:
        return AppColors.secondaryDark;
      case OrderStatus.shipped:
        return AppColors.primaryDark;
      case OrderStatus.delivered:
        return AppColors.primaryDark;
    }
  }

  Color get _statusBgColor {
    switch (order.status) {
      case OrderStatus.pending:
        return AppColors.secondaryLight;
      case OrderStatus.shipped:
        return AppColors.primaryLight;
      case OrderStatus.delivered:
        return AppColors.success;
    }
  }

  IconData get _statusIcon {
    switch (order.status) {
      case OrderStatus.pending:
        return Icons.access_time_rounded;
      case OrderStatus.shipped:
        return Icons.local_shipping_rounded;
      case OrderStatus.delivered:
        return Icons.check_circle_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: _statusBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(_statusIcon, size: 18),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTextWidget(
              'Order ${order.id}',
              style: AppTextStyles.styleBold16,
            ),
            const SizedBox(width: 6),
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: _statusBgColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: order.customerName,
                    style: AppTextStyles.styleBold16.copyWith(
                      color: AppColors.grayscale500,
                    ),
                  ),
                  TextSpan(
                    text: '  •  ',
                    style: AppTextStyles.styleRegular16.copyWith(
                      color: _statusBgColor,
                    ),
                  ),
                  TextSpan(
                    text: '\$${order.amount.toStringAsFixed(2)}',
                    style: AppTextStyles.styleBold16,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _statusBgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: AppTextWidget(
                order.statusAr,
                style: AppTextStyles.styleSemiBold13.copyWith(
                  color: _statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
