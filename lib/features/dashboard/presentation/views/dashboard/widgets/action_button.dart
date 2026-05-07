import 'package:flutter/material.dart';

import '../../../../../../core/utils/shared/widgets/app_text_widget.dart';
import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isPrimary ? AppColors.textPrimary : Colors.white;
    final fgColor = isPrimary ? Colors.white : AppColors.textSecondary;
    final borderColor = isPrimary ? Colors.transparent : AppColors.border;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: fgColor, size: 20),
            const SizedBox(height: 8),
            AppTextWidget(
              label,
              style: AppTextStyles.styleSemiBold13.copyWith(color: fgColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
