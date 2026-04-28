import 'package:dashboard_fruit_hub/core/entities/order_entity/order_status.dart';
import 'package:flutter/material.dart';

class StatusIconCircle extends StatelessWidget {
  final OrderStatus status;

  const StatusIconCircle({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(color: status.bg, shape: BoxShape.circle),
      child: Icon(status.icon, size: 20, color: status.fg),
    );
  }
}
