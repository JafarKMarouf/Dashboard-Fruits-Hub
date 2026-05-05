import 'package:flutter/material.dart';

import '../../../../../core/enums/customer_status.dart';
import '../../../../../core/utils/shared/widgets/app_text_widget.dart';
import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';

class StatusOptionSheet extends StatelessWidget {
  const StatusOptionSheet({
    super.key,
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  final CustomerStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: status.bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(status.icon, color: status.fgColor, size: 20),
      ),
      title: AppTextWidget(
        status.label,
        style: AppTextStyles.styleSemiBold16.copyWith(
          color: isSelected ? AppColors.primaryDark : AppColors.grayscale800,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle_rounded, color: AppColors.primaryDark)
          : null,
    );
  }
}
