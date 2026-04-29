import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_primary_button.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/features/inventory/domain/entities/inventory_entity.dart';
import 'package:dashboard_fruit_hub/features/inventory/presentation/manager/inventory_cubit/inventory_cubit.dart';
import 'package:dashboard_fruit_hub/features/inventory/presentation/views/widgets/inventory_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/shared/widgets/custom_network_image.dart';
import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({super.key, required this.product});

  final InventoryEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 90,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomNetworkImage(
                      imageUrl: product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Info column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        product.name,
                        style: AppTextStyles.styleBold17,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      // Price row
                      Row(
                        children: [
                          AppTextWidget(
                            '${product.price % 1 == 0 ? product.price.toInt() : product.price} ل.س',
                            style: AppTextStyles.styleSemiBold13.copyWith(
                              color: AppColors.grayscale700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          AppTextWidget(
                            '/ كجم',
                            style: AppTextStyles.styleRegular11.copyWith(
                              color: AppColors.grayscale600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Stock badge
                      _StockBadge(product: product),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ── Restock button ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: AppPrimaryButton(
              showShadow: false,
              backgroundColor: AppColors.green1_700,
              onPressed: () => _openRestockSheet(context),
              widget: Row(
                mainAxisAlignment: .center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      size: 20,
                      color: AppColors.green1_700,
                    ),
                  ),
                  const SizedBox(width: 16),
                  AppTextWidget(
                    'إعادة تعبئة',
                    style: AppTextStyles.styleBold14.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openRestockSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<InventoryCubit>(),
        child: RestockBottomSheet(product: product),
      ),
    );
  }
}

class _StockBadge extends StatelessWidget {
  const _StockBadge({required this.product});

  final InventoryEntity product;

  @override
  Widget build(BuildContext context) {
    final isLow = product.isLowStock;
    final bgColor = isLow ? AppColors.orange100 : AppColors.green1_100;
    final fgColor = isLow ? AppColors.orange600 : AppColors.green1_600;
    final icon = isLow
        ? Icons.warning_amber_rounded
        : Icons.inventory_2_outlined;
    final label = isLow
        ? '${product.quantity} كجم متبقي (منخفض)'
        : '${product.quantity} كجم متبقي';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: fgColor),
          const SizedBox(width: 4),
          AppTextWidget(
            label,
            style: AppTextStyles.styleBold13.copyWith(color: fgColor),
          ),
        ],
      ),
    );
  }
}
