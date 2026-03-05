import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';

import '../shared/widgets/app_text_widget.dart';

Future<bool> showConfirmExitDialog(
  BuildContext context, {
  void Function()? confirmExist,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.exit_to_app, color: AppColors.primaryDark, size: 28),
              SizedBox(width: 12),
              AppTextWidget('هل تريد الخروج؟'),
            ],
          ),
          content: const AppTextWidget(
            'لديك تغييرات غير محفوظة. هل تريد الخروج بدون حفظ؟',
            maxLines: 2,
            textDirection: TextDirection.rtl,
          ),
          actions: [
            ElevatedButton(
              onPressed:
                  confirmExist ?? () => Navigator.pop(dialogContext, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const AppTextWidget('خروج', color: AppColors.background),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const AppTextWidget('إلغاء'),
            ),
          ],
        ),
      ) ??
      false;
}
