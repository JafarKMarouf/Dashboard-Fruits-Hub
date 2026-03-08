import 'package:flutter/material.dart';

class BottomNavItemEntity {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String title;

  BottomNavItemEntity({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.title,
  });
}

List<BottomNavItemEntity> get navigationBarItems => [
  BottomNavItemEntity(
    activeIcon: Icons.dashboard_rounded,
    inactiveIcon: Icons.dashboard_customize_outlined,
    title: 'الرئيسية',
  ),
  BottomNavItemEntity(
    activeIcon: Icons.inventory_2_rounded,
    inactiveIcon: Icons.inventory_2_outlined,
    title: 'المخزون',
  ),
  BottomNavItemEntity(
    activeIcon: Icons.shopping_bag_rounded,
    inactiveIcon: Icons.shopping_bag_outlined,
    title: 'الطلبات',
  ),
  BottomNavItemEntity(
    activeIcon: Icons.bar_chart_rounded,
    inactiveIcon: Icons.bar_chart_outlined,
    title: 'التقارير',
  ),
];
