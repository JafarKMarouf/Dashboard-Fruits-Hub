import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class FilterItem<T> {
  final T value;
  final String label;
  final int? count;
  final Color? bgColor;
  final Color? fgColor;
  final IconData? icon;

  const FilterItem({
    required this.value,
    required this.label,
    this.count,
    this.bgColor,
    this.fgColor,
    this.icon,
  });
}

class AppFilterBar<T> extends StatelessWidget {
  const AppFilterBar({
    super.key,
    required this.items,
    required this.activeValue,
    required this.onSelected,
  });

  final List<FilterItem<T>> items;
  final T activeValue;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (_, index) {
          final item = items[index];
          final isActive = item.value == activeValue;

          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: _FilterChip<T>(
              item: item,
              isActive: isActive,
              onTap: () => onSelected(item.value),
            ),
          );
        },
      ),
    );
  }
}

class _FilterChip<T> extends StatelessWidget {
  const _FilterChip({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final FilterItem<T> item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final chipBg = item.bgColor ?? AppColors.green1_600;
    const activeText = Colors.white;
    final inactiveText = item.fgColor ?? AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive ? chipBg : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon ────────────────────────────────────────────────────────
            if (item.icon != null) ...[
              Icon(item.icon, size: 16, color: item.fgColor),
              const SizedBox(width: 4),
            ],

            // ── Label ────────────────────────────────────────────────────────
            AppTextWidget(
              item.label,
              style: AppTextStyles.styleBold13.copyWith(
                color: item.fgColor,
                // status.fg
              ),
            ),

            // ── Count badge ──────────────────────────────────────────────────
            if ((item.count ?? 0) > 0) ...[
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isActive ? activeText : inactiveText,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AppTextWidget(
                  '${item.count}',
                  style: AppTextStyles.styleBold11.copyWith(
                    color: isActive ? inactiveText : activeText,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
