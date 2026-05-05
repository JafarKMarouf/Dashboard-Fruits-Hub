import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';

enum OrderStatus { all, pending, shipped, delivered, cancelled }

extension OrderStatusX on OrderStatus {
  String get labelAr {
    switch (this) {
      case OrderStatus.all:
        return 'الكل';
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.shipped:
        return 'تم الشحن';
      case OrderStatus.delivered:
        return 'تم التسليم';
      case OrderStatus.cancelled:
        return 'ملغي';
    }
  }

  IconData get icon {
    switch (this) {
      case OrderStatus.all:
        return Icons.list_rounded;
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

  Color get bg {
    switch (this) {
      case OrderStatus.all:
        return AppColors.primary;
      case OrderStatus.pending:
        return AppColors.orange400;
      case OrderStatus.shipped:
        return AppColors.green1_200;
      case OrderStatus.delivered:
        return AppColors.green1_400;
      case OrderStatus.cancelled:
        return AppColors.grayscale300;
    }
  }

  Color get fg {
    switch (this) {
      case OrderStatus.all:
        return AppColors.primaryDark;
      case OrderStatus.pending:
        return AppColors.orange700;
      case OrderStatus.shipped:
        return AppColors.green1_600;
      case OrderStatus.delivered:
        return AppColors.primaryDark;
      case OrderStatus.cancelled:
        return AppColors.grayscale500;
    }
  }

  static OrderStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'all':
        return OrderStatus.all;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }
}
