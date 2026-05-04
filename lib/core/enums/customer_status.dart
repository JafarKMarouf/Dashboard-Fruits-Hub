import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';

enum CustomerStatus { all, active, blocked, suspended }

extension CustomerStatusX on CustomerStatus {
  String get label {
    switch (this) {
      case CustomerStatus.all:
        return 'الكل';
      case CustomerStatus.active:
        return 'نشط';
      case CustomerStatus.blocked:
        return 'محظور';
      case CustomerStatus.suspended:
        return 'معلق';
    }
  }

  String get value {
    switch (this) {
      case CustomerStatus.all:
        return 'all';
      case CustomerStatus.active:
        return 'active';
      case CustomerStatus.blocked:
        return 'blocked';
      case CustomerStatus.suspended:
        return 'suspended';
    }
  }

  Color get bgColor {
    switch (this) {
      case CustomerStatus.all:
        return AppColors.primary;
      case CustomerStatus.active:
        return AppColors.success;
      case CustomerStatus.blocked:
        return AppColors.danger;
      case CustomerStatus.suspended:
        return AppColors.warning;
    }
  }

  Color get fgColor {
    switch (this) {
      case CustomerStatus.all:
        return AppColors.primaryDark;
      case CustomerStatus.active:
        return AppColors.success;
      case CustomerStatus.blocked:
        return AppColors.danger;
      case CustomerStatus.suspended:
        return AppColors.warning;
    }
  }

  IconData get icon {
    switch (this) {
      case CustomerStatus.all:
        return Icons.people_rounded;
      case CustomerStatus.active:
        return Icons.check_circle_rounded;
      case CustomerStatus.blocked:
        return Icons.cancel_rounded;
      case CustomerStatus.suspended:
        return Icons.pause_circle_rounded;
    }
  }

  static CustomerStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'all':
        return CustomerStatus.all;
      case 'active':
        return CustomerStatus.active;
      case 'blocked':
        return CustomerStatus.blocked;
      case 'suspended':
        return CustomerStatus.suspended;
      default:
        return CustomerStatus.active;
    }
  }
}
