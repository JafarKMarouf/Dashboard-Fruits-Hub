import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/features/orders/domain/entities/order_status.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_text_styles.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;
  final bool small;

  const OrderStatusBadge({super.key, required this.status, this.small = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 10,
        vertical: small ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: status.bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: AppTextWidget(
        status.labelAr,
        style: (small ? AppTextStyles.styleBold11 : AppTextStyles.styleBold13)
            .copyWith(color: status.fg),
      ),
    );
  }
}
