import 'package:dashboard_fruit_hub/core/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/core/shared/widgets/custom_network_image.dart';
import 'package:dashboard_fruit_hub/features/orders/domain/entities/order_item_entity.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';

class ItemsThumbnails extends StatelessWidget {
  final List<OrderItemEntity> items;

  const ItemsThumbnails({super.key, required this.items});

  static const double _size = 42.0;
  static const double _overlap = 14.0;
  static const int _maxVisible = 3;
  static const double _borderWidth = 2.5;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final visible = items.take(_maxVisible).toList();

    final circleCount = 1 + visible.length;
    final stackWidth = _size + (_size - _overlap) * (circleCount - 1);

    return SizedBox(
      width: stackWidth,
      height: _size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...visible.asMap().entries.map((e) {
            final stackIndex = e.key + 1;
            return Positioned(
              left: stackIndex * (_size - _overlap),
              child: _ImageCircle(imageUrl: e.value.imageUrl),
            );
          }),

          if (items.length - 2 > 0)
            Positioned(left: 0, child: _CountBadge(count: items.length - 2)),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;

  const _CountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ItemsThumbnails._size,
      height: ItemsThumbnails._size,
      decoration: BoxDecoration(
        color: AppColors.grayscale100,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: ItemsThumbnails._borderWidth,
        ),
      ),
      child: Center(
        child: AppTextWidget(
          '$count+',
          style: AppTextStyles.styleBold13.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Image circle  — CachedNetworkImage inside a circle with white border
// ─────────────────────────────────────────────────────────────────────────────

class _ImageCircle extends StatelessWidget {
  final String? imageUrl;

  const _ImageCircle({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ItemsThumbnails._size,
      height: ItemsThumbnails._size,
      decoration: BoxDecoration(
        color: AppColors.orange50,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: ItemsThumbnails._borderWidth,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? CustomNetworkImage(imageUrl: imageUrl)
          : const _Placeholder(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Placeholder — shown while loading or on error
// ─────────────────────────────────────────────────────────────────────────────

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.eco_rounded, size: 18, color: AppColors.primary),
    );
  }
}
