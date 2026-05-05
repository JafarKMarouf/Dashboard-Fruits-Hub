import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/features/customers/presentation/manager/customer_cubit/customers_cubit.dart';
import 'package:dashboard_fruit_hub/features/customers/presentation/views/widgets/customer_avatar.dart';
import 'package:dashboard_fruit_hub/features/customers/presentation/views/widgets/customer_status_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../../../../core/enums/customer_status.dart';
import 'customers_status_badge.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key, required this.customer});

  final CustomerEntity customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showStatusSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                CustomerAvatar(name: customer.name),
                const SizedBox(width: 12),
                // ── Info column ────────────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppTextWidget(
                              customer.name,
                              style: AppTextStyles.styleBold16,
                              maxLines: 1,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                          const SizedBox(width: 8),

                          CustomersStatusBadge(status: customer.status),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // Email
                      AppTextWidget(
                        customer.email,
                        style: AppTextStyles.styleRegular13.copyWith(
                          color: customer.status == CustomerStatus.blocked
                              ? AppColors.error.withOpacity(0.7)
                              : AppColors.grayscale400,
                        ),
                        maxLines: 1,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.grayscale400,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showStatusSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<CustomersCubit>(),
        child: CustomerStatusSheet(customer: customer),
      ),
    );
  }
}
