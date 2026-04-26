import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../domain/entities/order_entity.dart';

class OrderStatusBadge extends StatelessWidget {
  final OrderStatus status;
  final bool small;

  const OrderStatusBadge({super.key, required this.status, this.small = false});

  Color get _bg {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.orange100;
      case OrderStatus.shipped:
        return AppColors.green1_100;
      case OrderStatus.delivered:
        return AppColors.green100;
      case OrderStatus.cancelled:
        return AppColors.grayscale100;
    }
  }

  Color get _fg {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.orange700;
      case OrderStatus.shipped:
        return AppColors.green1_600;
      case OrderStatus.delivered:
        return AppColors.green700;
      case OrderStatus.cancelled:
        return AppColors.grayscale600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 10,
        vertical: small ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: AppTextWidget(
        status.labelAr,
        style:
            (small
                    ? AppTextStyles.styleSemiBold11
                    : AppTextStyles.styleSemiBold13)
                .copyWith(color: _fg),
      ),
    );
  }
}
