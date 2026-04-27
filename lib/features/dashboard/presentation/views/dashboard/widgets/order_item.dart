import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/core/entities/order_entity/order_entity.dart';
import 'package:dashboard_fruit_hub/core/entities/order_entity/order_status.dart';
import 'package:dashboard_fruit_hub/features/orders/presentation/views/widgets/order_status_badge.dart';
import 'package:dashboard_fruit_hub/features/orders/presentation/views/widgets/status_icon_circle.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';

class OrderItem extends StatelessWidget {
  final OrderEntity order;

  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        leading: StatusIconCircle(status: order.status),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTextWidget(
              order.formatOrderId,
              style: AppTextStyles.styleBold16,
            ),
            const SizedBox(width: 6),
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: order.status.fg,
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
                    text: order.formatPrice,
                    style: AppTextStyles.styleBold16,
                  ),
                  TextSpan(
                    text: '  •  ',
                    style: AppTextStyles.styleRegular16.copyWith(
                      color: order.status.fg,
                    ),
                  ),
                  TextSpan(
                    text: order.shippingAddress!.name!,
                    style: AppTextStyles.styleBold16.copyWith(
                      color: AppColors.grayscale500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            OrderStatusBadge(status: order.status),
          ],
        ),
      ),
    );
  }
}
