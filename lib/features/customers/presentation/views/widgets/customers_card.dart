import 'package:dashboard_fruit_hub/core/utils/shared/widgets/app_text_widget.dart';
import 'package:dashboard_fruit_hub/features/customers/presentation/manager/customer_cubit/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../../../../core/enums/customer_status.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({super.key, required this.customer});

  final CustomerEntity customer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
                // ── Chevron ────────────────────────────────────────────────
                const Icon(
                  Icons.chevron_left_rounded,
                  color: AppColors.grayscale300,
                  size: 20,
                ),
                const SizedBox(width: 8),

                // ── Info column ────────────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status badge + name row
                      Row(
                        children: [
                          _StatusBadge(status: customer.status),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppTextWidget(
                              customer.name,
                              style: AppTextStyles.styleBold16,
                              maxLines: 1,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
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
                      const SizedBox(height: 6),

                      // Orders count + city row
                      // Row(
                      //   children: [
                      //     if (customer.city != null) ...[
                      //       const Icon(
                      //         Icons.location_on_outlined,
                      //         size: 13,
                      //         color: AppColors.grayscale400,
                      //       ),
                      //       const SizedBox(width: 2),
                      //       AppTextWidget(
                      //         customer.city!,
                      //         style: AppTextStyles.styleRegular11.copyWith(
                      //           color: AppColors.grayscale400,
                      //         ),
                      //       ),
                      //       const SizedBox(width: 12),
                      //     ],
                      //     const Icon(
                      //       Icons.shopping_bag_outlined,
                      //       size: 13,
                      //       color: AppColors.grayscale400,
                      //     ),
                      //     const SizedBox(width: 2),
                      //     AppTextWidget(
                      //       '${customer.ordersCount} طلب',
                      //       style: AppTextStyles.styleRegular11.copyWith(
                      //         color: AppColors.grayscale400,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // ── Avatar ─────────────────────────────────────────────────
                // _CustomerAvatar(customer: customer),
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
        child: _CustomerStatusSheet(customer: customer),
      ),
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────────

// class _CustomerAvatar extends StatelessWidget {
//   const _CustomerAvatar({required this.customer});

//   final CustomerEntity customer;

//   // Generates a consistent pastel color from the name string.
//   Color _avatarColor() {
//     final colors = [
//       const Color(0xFFD7F4E3),
//       const Color(0xFFFFE4E4),
//       const Color(0xFFFDECCE),
//       const Color(0xFFE3E8FF),
//       const Color(0xFFFFF3CD),
//     ];
//     final index =
//         customer.name.codeUnits.fold(0, (a, b) => a + b) % colors.length;
//     return colors[index];
//   }

//   Color _fgColor() {
//     final colors = [
//       const Color(0xFF2D9F5D),
//       const Color(0xFFC0392B),
//       const Color(0xFFC2820A),
//       const Color(0xFF3D52A0),
//       const Color(0xFF856404),
//     ];
//     final index =
//         customer.name.codeUnits.fold(0, (a, b) => a + b) % colors.length;
//     return colors[index];
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (customer.imageUrl != null && customer.imageUrl!.isNotEmpty) {
//       return ClipOval(
//         child: SizedBox(
//           width: 48,
//           height: 48,
//           child: CustomNetworkImage(
//             imageUrl: customer.imageUrl,
//             width: 48,
//             height: 48,
//             fit: BoxFit.cover,
//           ),
//         ),
//       );
//     }

//     return Container(
//       width: 48,
//       height: 48,
//       decoration: BoxDecoration(color: _avatarColor(), shape: BoxShape.circle),
//       child: Center(
//         child: Text(
//           customer.initials,
//           style: AppTextStyles.styleBold19.copyWith(color: _fgColor()),
//         ),
//       ),
//     );
//   }
// }

// ── Status badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

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
        style: AppTextStyles.styleSemiBold11.copyWith(color: status.fgColor),
      ),
    );
  }
}

// ── Status bottom sheet ───────────────────────────────────────────────────────

class _CustomerStatusSheet extends StatelessWidget {
  const _CustomerStatusSheet({required this.customer});

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
            (status) => _StatusOption(
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

class _StatusOption extends StatelessWidget {
  const _StatusOption({
    required this.status,
    required this.isSelected,
    required this.onTap,
  });

  final CustomerStatus status;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: status.bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(status.icon, color: status.fgColor, size: 20),
      ),
      title: AppTextWidget(
        status.label,
        style: AppTextStyles.styleSemiBold16.copyWith(
          color: isSelected ? AppColors.primary : AppColors.grayscale800,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
          : null,
    );
  }
}
