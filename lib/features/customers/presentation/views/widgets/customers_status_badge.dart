import 'package:dashboard_fruit_hub/core/enums/customer_status.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/shared/widgets/app_text_widget.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';

class CustomersStatusBadge extends StatelessWidget {
  const CustomersStatusBadge({super.key, required this.status});

  final CustomerStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: status.bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppTextWidget(
        status.label,
        style: AppTextStyles.styleSemiBold11.copyWith(
          color: status.fgColor.withOpacity(.2),
        ),
      ),
    );
  }
}
