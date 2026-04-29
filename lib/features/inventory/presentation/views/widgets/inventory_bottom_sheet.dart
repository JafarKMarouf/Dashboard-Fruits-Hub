import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_primary_button.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/features/inventory/presentation/manager/inventory_cubit/inventory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../domain/entities/inventory_entity.dart';

class RestockBottomSheet extends StatefulWidget {
  const RestockBottomSheet({super.key, required this.product});

  final InventoryEntity product;

  @override
  State<RestockBottomSheet> createState() => _RestockBottomSheetState();
}

class _RestockBottomSheetState extends State<RestockBottomSheet> {
  int _addQty = 10;
  bool _isLoading = false;

  void _increment() => setState(() => _addQty++);
  void _decrement() {
    if (_addQty > 1) setState(() => _addQty--);
  }

  Future<void> _confirm() async {
    setState(() => _isLoading = true);
    await context.read<InventoryCubit>().restock(
      productId: widget.product.id,
      addQuantity: _addQty,
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + bottom),
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

          // Title
          AppTextWidget(
            'إعادة تعبئة — ${widget.product.name}',
            style: AppTextStyles.styleBold19,
          ),
          const SizedBox(height: 4),
          AppTextWidget(
            'المخزون الحالي: ${widget.product.quantity} كجم',
            style: AppTextStyles.styleRegular13.copyWith(
              color: AppColors.grayscale500,
            ),
          ),
          const SizedBox(height: 24),

          // Quantity stepper
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StepButton(icon: Icons.remove_rounded, onTap: _decrement),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      AppTextWidget(
                        '$_addQty',
                        style: AppTextStyles.styleBold33,
                      ),
                      AppTextWidget(
                        'كجم للإضافة',
                        style: AppTextStyles.styleRegular11.copyWith(
                          color: AppColors.grayscale400,
                        ),
                      ),
                    ],
                  ),
                ),
                _StepButton(icon: Icons.add_rounded, onTap: _increment),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // New total preview
          Center(
            child: AppTextWidget(
              'المخزون الجديد: ${widget.product.quantity + _addQty} كجم',
              style: AppTextStyles.styleSemiBold13.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Confirm button
          AppPrimaryButton(
            onPressed: _isLoading ? null : _confirm,
            text: _isLoading ? 'جارٍ الحفظ...' : 'تأكيد التعبئة',
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.green1_100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
    );
  }
}
