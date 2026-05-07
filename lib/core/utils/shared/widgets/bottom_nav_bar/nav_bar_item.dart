import 'package:flutter/material.dart';

import '../../../styles/app_colors.dart';
import '../../../styles/app_text_styles.dart';
import '../app_text_widget.dart';
import 'bottom_nav_item_entity.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.isSelected,
    required this.bottomNavigationBarEntity,
    required this.onTap,
  });

  final bool isSelected;
  final BottomNavItemEntity bottomNavigationBarEntity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: isSelected
            ? Container(
                key: const ValueKey(true),
                decoration: ShapeDecoration(
                  color: const Color(0xFFEEEEEE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const ShapeDecoration(
                        color: AppColors.green1_500,
                        shape: OvalBorder(),
                      ),
                      child: Center(
                        child: Icon(
                          bottomNavigationBarEntity.activeIcon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    AppTextWidget(
                      bottomNavigationBarEntity.title,
                      style: AppTextStyles.styleSemiBold13.copyWith(
                        color: AppColors.green1_500,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              )
            : Padding(
                key: const ValueKey(false),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  bottomNavigationBarEntity.inactiveIcon,
                  color: AppColors.grayscale500,
                ),
              ),
      ),
    );
  }
}
