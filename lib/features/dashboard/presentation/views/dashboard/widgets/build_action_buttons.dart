import 'package:flutter/material.dart';

import '../../add_product/add_product_view.dart';
import 'action_button.dart';

class BuildActionButtons extends StatelessWidget {
  const BuildActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      (
        label: 'إضافة منتج',
        icon: Icons.add,
        onTap: () {
          Navigator.of(context).pushNamed(AddProductView.routeName);
        },
        isPrimary: true,
      ),
      (
        label: 'فحص المخزون',
        icon: Icons.inventory_2_rounded,
        onTap: () {},
        isPrimary: false,
      ),
      (
        label: 'التقارير',
        icon: Icons.bar_chart_rounded,
        onTap: () {},
        isPrimary: false,
      ),
    ];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: actions.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, index) => ActionButton(
          icon: actions[index].icon,
          label: actions[index].label,
          onTap: actions[index].onTap,
          isPrimary: actions[index].isPrimary,
        ),
      ),
    );
  }
}
