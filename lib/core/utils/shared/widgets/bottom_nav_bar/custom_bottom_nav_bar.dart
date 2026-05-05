import 'package:dashboard_fruit_hub/core/utils/shared/widgets/bottom_nav_bar/bottom_nav_item_entity.dart';
import 'package:flutter/material.dart';

import 'nav_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });
  static const _rightIndices = [0, 1];
  static const _leftIndices = [2, 3];

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: const ShapeDecoration(
        color: Color.from(alpha: 1, red: 1, green: 1, blue: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 25,
            offset: Offset(0, -2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: SizedBox(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ..._rightIndices.map(
              (i) => NavBarItem(
                isSelected: selectedIndex == i,
                bottomNavigationBarEntity: navigationBarItems[i],
                onTap: () => onItemTapped(i),
              ),
            ),
            const SizedBox(width: 40),
            ..._leftIndices.map(
              (i) => NavBarItem(
                isSelected: selectedIndex == i,
                bottomNavigationBarEntity: navigationBarItems[i],
                onTap: () => onItemTapped(i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
