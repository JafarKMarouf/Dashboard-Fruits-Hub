import 'package:dashboard_fruit_hub/core/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/shared/widgets/app_text_widget.dart';
import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../domain/entities/order_entity.dart';
import 'item__thumbnails.dart';
import 'order_status_badge.dart';
import 'status_icon_circle.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  final bool isUpdating;
  final VoidCallback onTap;
  final ValueChanged<OrderStatus> onStatusChanged;

  const OrderCard({
    super.key,
    required this.order,
    required this.isUpdating,
    required this.onTap,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isUpdating ? null : onTap,
      child: AnimatedOpacity(
        opacity: isUpdating ? 0.6 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: .end,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  children: [
                    StatusIconCircle(status: order.status),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        AppTextWidget(
                          order.displayNumber,
                          style: AppTextStyles.styleSemiBold13.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        AppTextWidget(
                          order.customerName,
                          style: AppTextStyles.styleBold19,
                        ),
                      ],
                    ),
                    const Spacer(),
                    OrderStatusBadge(status: order.status),
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 10),

                // ── Footer row ──────────────────────────────────────────────
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    if (order.items.isNotEmpty)
                      ItemsThumbnails(items: order.items),

                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        AppTextWidget(
                          'الإجمالي',
                          style: AppTextStyles.styleRegular11.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AppTextWidget(
                          '${order.finalTotal.toStringAsFixed(2)} ل.س',
                          style: AppTextStyles.styleBold16,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    if (isUpdating)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else if (order.status == OrderStatus.pending)
                      _AcceptButton(
                        onTap: () => onStatusChanged(OrderStatus.shipped),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AcceptButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AcceptButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      onPressed: onTap,
      text: 'قبول الطلب',
      height: 40,
      width: MediaQuery.sizeOf(context).width * .65,
    );
  }
}
