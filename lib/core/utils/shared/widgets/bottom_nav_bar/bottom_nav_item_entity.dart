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
    inactiveIcon: Icons.dashboard_outlined,
    title: 'الرئيسية',
  ),
  BottomNavItemEntity(
    activeIcon: Icons.inventory_2_rounded,
    inactiveIcon: Icons.inventory_2_outlined,
    title: 'المخزون',
  ),
  BottomNavItemEntity(
    activeIcon: Icons.shopping_cart_rounded,
    inactiveIcon: Icons.shopping_cart_outlined,
    title: 'الطلبات',
  ),
  BottomNavItemEntity(
    activeIcon: Icons.people_alt_rounded,
    inactiveIcon: Icons.people_alt_outlined,
    title: 'العملاء',
  ),
];
