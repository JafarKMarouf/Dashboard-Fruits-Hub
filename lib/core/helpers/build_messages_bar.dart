import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../shared/widgets/app_text_widget.dart';
import '../utils/styles/app_text_styles.dart';

void buildErrorBar(BuildContext context, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    dragToClose: false,
    closeOnClick: false,
    title: AppTextWidget(message, style: AppTextStyles.styleSemiBold13),
    autoCloseDuration: const Duration(seconds: 3),
  );
}

void buildWarningBar(BuildContext context, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.warning,
    style: ToastificationStyle.flatColored,
    dragToClose: false,
    closeOnClick: false,
    title: AppTextWidget(message, style: AppTextStyles.styleSemiBold13),
    autoCloseDuration: const Duration(seconds: 3),
  );
}

void buildSuccessMessage(BuildContext context, String message) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    dragToClose: false,
    closeOnClick: false,
    title: AppTextWidget(message, style: AppTextStyles.styleSemiBold13),
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 2),
  );
}
