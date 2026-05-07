import 'dart:io';

import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_colors.dart';
import 'package:dashboard_fruit_hub/core/utils/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ReviewStep extends StatelessWidget {
  const ReviewStep({
    super.key,
    required this.productImage,
    required this.name,
    required this.code,
    required this.price,
    required this.quantity,
    required this.description,
    required this.isFeatured,
    required this.isOrganic,
    required this.expirationMonths,
    required this.numberOfCalories,
    required this.unitAmount,
  });

  final File? productImage;
  final String name;
  final String code;
  final String price;
  final String quantity;
  final String description;
  final bool isFeatured;
  final bool isOrganic;
  final String expirationMonths;
  final String numberOfCalories;
  final String unitAmount;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderLight),
      ),
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTextWidget(
              'مراجعة المنتج',
              style: AppTextStyles.styleBold16,
            ),
            const Divider(height: 24),

            // ── Image + basic info ──────────────────────────────────────────
            _buildProductHeader(),
            const SizedBox(height: 16),

            // ── Details grid ────────────────────────────────────────────────
            const AppTextWidget('التفاصيل', style: AppTextStyles.styleBold14),
            const SizedBox(height: 12),
            _buildDetailsGrid(),
            const SizedBox(height: 16),

            // ── Badges ──────────────────────────────────────────────────────
            _buildBadges(),

            // ── Description ─────────────────────────────────────────────────
            if (description.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              const AppTextWidget('الوصف', style: AppTextStyles.styleBold14),
              const SizedBox(height: 6),
              AppTextWidget(
                description.trim(),
                style: AppTextStyles.styleSemiBold13,
                maxLines: 3,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProductHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProductImage(),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextWidget(
                name.isEmpty ? 'بدون اسم' : name,
                style: AppTextStyles.styleBold19,
              ),
              const SizedBox(height: 4),
              AppTextWidget(
                'الكود: $code',
                style: AppTextStyles.styleSemiBold16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    if (productImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          productImage!,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.image_not_supported_outlined),
    );
  }

  Widget _buildDetailsGrid() {
    final items = [
      _DetailItem(
        icon: Icons.attach_money_rounded,
        label: 'السعر',
        value: '$price ل.س',
      ),
      _DetailItem(
        icon: Icons.inventory_2_outlined,
        label: 'الكمية',
        value: quantity,
      ),
      _DetailItem(
        icon: Icons.hourglass_bottom,
        label: 'الصلاحية',
        value: '$expirationMonths شهر',
      ),
      _DetailItem(
        icon: Icons.local_fire_department,
        label: 'السعرات',
        value: '$numberOfCalories كالوري',
      ),
      _DetailItem(
        icon: Icons.scale_outlined,
        label: 'لكل',
        value: '$unitAmount غرام',
      ),
    ];

    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(item.icon, size: 18, color: AppColors.primaryDark),
                  const SizedBox(width: 8),
                  AppTextWidget(
                    '${item.label}:',
                    style: AppTextStyles.styleBold13,
                  ),
                  const SizedBox(width: 6),
                  AppTextWidget(
                    item.value,
                    style: AppTextStyles.styleSemiBold16,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBadges() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (isFeatured)
          _buildBadge(
            icon: Icons.star_rounded,
            label: 'منتج مميز',
            color: AppColors.secondary,
          ),
        if (isOrganic)
          _buildBadge(
            icon: Icons.eco_rounded,
            label: 'عضوي',
            color: AppColors.primary,
          ),
        if (!isFeatured && !isOrganic)
          _buildBadge(
            icon: Icons.check_circle_outline,
            label: 'منتج عادي',
            color: AppColors.grayscale500,
          ),
      ],
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          AppTextWidget(
            label,
            style: AppTextStyles.styleSemiBold15.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _DetailItem {
  const _DetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}
