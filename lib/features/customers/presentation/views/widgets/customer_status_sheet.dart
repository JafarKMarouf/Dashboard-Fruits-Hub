import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/customer_status.dart';
import '../../../../../core/utils/shared/widgets/app_text_widget.dart';
import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../manager/customer_cubit/customers_cubit.dart';
import 'status_sheet_option.dart';

class CustomerStatusSheet extends StatelessWidget {
  const CustomerStatusSheet({super.key, required this.customer});

  final CustomerEntity customer;

  static const _options = [
    CustomerStatus.active,
    CustomerStatus.blocked,
    CustomerStatus.suspended,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 36),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grayscale200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          AppTextWidget(
            'تغيير حالة ${customer.name}',
            style: AppTextStyles.styleBold19,
          ),
          const SizedBox(height: 4),
          AppTextWidget(
            'الحالة الحالية: ${customer.status.label}',
            style: AppTextStyles.styleRegular13.copyWith(
              color: AppColors.grayscale500,
            ),
          ),
          const SizedBox(height: 20),

          ..._options.map(
            (status) => StatusOptionSheet(
              status: status,
              isSelected: customer.status == status,
              onTap: () {
                Navigator.pop(context);
                context.read<CustomersCubit>().updateStatus(
                  customerId: customer.id,
                  status: status,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
