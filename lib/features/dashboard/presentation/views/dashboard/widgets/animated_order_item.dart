import 'package:dashboard_fruit_hub/features/orders/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';

import 'order_item.dart';

class AnimatedOrderItem extends StatelessWidget {
  const AnimatedOrderItem({
    super.key,
    required this.order,
    required this.entryController,
    required this.delayFraction,
  });

  final OrderEntity order;
  final AnimationController entryController;
  final double delayFraction;

  @override
  Widget build(BuildContext context) {
    final endFraction = (delayFraction + 0.25).clamp(0.0, 1.0);

    final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: entryController,
        curve: Interval(delayFraction, endFraction, curve: Curves.easeOut),
      ),
    );

    final slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: entryController,
            curve: Interval(
              delayFraction,
              endFraction,
              curve: Curves.easeOutCubic,
            ),
          ),
        );

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: OrderItem(order: order),
      ),
    );
  }
}
