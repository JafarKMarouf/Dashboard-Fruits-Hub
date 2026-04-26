import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../domain/entities/order_entity.dart';

class StatusIconCircle extends StatelessWidget {
  final OrderStatus status;

  const StatusIconCircle({super.key, required this.status});

  IconData get _icon {
    switch (status) {
      case OrderStatus.pending:
        return Icons.hourglass_top_rounded;
      case OrderStatus.shipped:
        return Icons.local_shipping_rounded;
      case OrderStatus.delivered:
        return Icons.check_circle_rounded;
      case OrderStatus.cancelled:
        return Icons.cancel_rounded;
    }
  }

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
        return AppColors.orange600;
      case OrderStatus.shipped:
        return AppColors.green1_600;
      case OrderStatus.delivered:
        return AppColors.green600;
      case OrderStatus.cancelled:
        return AppColors.grayscale500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(color: _bg, shape: BoxShape.circle),
      child: Icon(_icon, size: 20, color: _fg),
    );
  }
}
