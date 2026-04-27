import 'package:dashboard_fruit_hub/core/utils/shared/widgets/bottom_nav_bar/bottom_nav_item_entity.dart';
import 'package:flutter/material.dart';

import 'nav_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navigationBarItems.asMap().entries.map((e) {
          return NavBarItem(
            isSelected: selectedIndex == e.key,
            bottomNavigationBarEntity: e.value,
            onTap: () => onItemTapped(e.key),
          );
        }).toList(),
      ),
    );
  }
}
