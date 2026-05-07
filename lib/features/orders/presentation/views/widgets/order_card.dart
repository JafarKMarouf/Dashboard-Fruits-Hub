import 'package:dashboard_fruit_hub/core/entities/order_entity/order_entity.dart';
import 'package:dashboard_fruit_hub/core/entities/order_entity/order_entity_x.dart';
import 'package:dashboard_fruit_hub/core/enums/order_status.dart';
import 'package:dashboard_fruit_hub/core/l10n/l10n.dart';
import 'package:dashboard_fruit_hub/core/utils/extensions/date_time_extensions.dart';
import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/utils/shared/widgets/app_text_widget.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ────────────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusIconCircle(status: order.status),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            order.formatOrderId(context),
                            style: AppTextStyles.styleSemiBold13.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          AppTextWidget(
                            order.shippingAddress?.name ?? '—',
                            style: AppTextStyles.styleBold19,
                          ),
                        ],
                      ),
                    ),
                    OrderStatusBadge(status: order.status),
                    _MoreMenu(order: order, onStatusChanged: onStatusChanged),
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 10),

                // ── Footer ────────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _FooterLeft(order: order),
                    _PriceSummary(order: order),
                  ],
                ),

                const SizedBox(height: 10),

                Skeleton.replace(
                  replacement: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.grayscale200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _ActionRow(
                    order: order,
                    isUpdating: isUpdating,
                    onStatusChanged: onStatusChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Footer left: thumbnails OR status timestamp ───────────────────────────

class _FooterLeft extends StatelessWidget {
  final OrderEntity order;

  const _FooterLeft({required this.order});

  @override
  Widget build(BuildContext context) {
    final showThumbnails =
        order.status == OrderStatus.pending ||
        order.status == OrderStatus.shipped;

    if (showThumbnails) {
      // Fixed: was order.items! (null bang) — guard with empty fallback.
      final items = order.items ?? const [];
      return items.isEmpty
          ? const SizedBox.shrink()
          : ItemsThumbnails(items: items);
    }

    final l10n = AppLocalizations.of(context);
    final label = order.status == OrderStatus.cancelled
        ? l10n.statusCancelled
        : l10n.statusDelivered;

    // updatedAt is nullable; arabicTimeAgo extension already handles null → "منذ لحظات"
    return AppTextWidget(
      '$label ${order.updatedAt.arabicTimeAgo(context)}',
      style: AppTextStyles.styleBold14.copyWith(color: AppColors.textSecondary),
    );
  }
}

// ─── Price summary ─────────────────────────────────────────────────────────

class _PriceSummary extends StatelessWidget {
  final OrderEntity order;

  const _PriceSummary({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextWidget(
          'الإجمالي',
          style: AppTextStyles.styleRegular11.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        AppTextWidget(
          order.formatPrice(context),
          style: AppTextStyles.styleBold16,
        ),
      ],
    );
  }
}

// ─── More menu ─────────────────────────────────────────────────────────────

class _MoreMenu extends StatelessWidget {
  final OrderEntity order;
  final ValueChanged<OrderStatus> onStatusChanged;

  const _MoreMenu({required this.order, required this.onStatusChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Color(0xFF4B5563)),
      onSelected: (_) {},
      itemBuilder: (_) => [
        const PopupMenuItem(
          value: 'details',
          child: AppTextWidget('تفاصيل الطلب'),
        ),
        if (order.status == OrderStatus.pending)
          PopupMenuItem(
            value: 'cancel',
            child: GestureDetector(
              onTap: () => onStatusChanged(OrderStatus.cancelled),
              child: AppTextWidget(
                'إلغاء الطلب',
                style: AppTextStyles.styleRegular16.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Action row ────────────────────────────────────────────────────────────

class _ActionRow extends StatelessWidget {
  final OrderEntity order;
  final bool isUpdating;
  final ValueChanged<OrderStatus> onStatusChanged;

  const _ActionRow({
    required this.order,
    required this.isUpdating,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isUpdating) return const _LoadingButton();
    if (order.status == OrderStatus.pending) {
      return _AcceptButton(onTap: () => onStatusChanged(OrderStatus.shipped));
    }
    return const SizedBox.shrink();
  }
}

// ─── Accept button ─────────────────────────────────────────────────────────

class _AcceptButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AcceptButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      onPressed: onTap,
      text: 'قبول الطلب',
      height: 40,
      width: MediaQuery.sizeOf(context).width * .80,
    );
  }
}

// ─── Loading button ────────────────────────────────────────────────────────

class _LoadingButton extends StatelessWidget {
  const _LoadingButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        ),
      ),
    );
  }
}
