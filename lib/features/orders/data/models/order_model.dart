import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_fruit_hub/core/entities/order_entity/order_entity.dart';
import 'package:dashboard_fruit_hub/core/entities/order_entity/order_status.dart';

import 'order_item_model.dart';
import 'shipping_address_model.dart';

class OrderModel {
  final String userId;

  final ShippingAddressModel shippingAddress;

  final List<OrderItemModel> items;

  final double totalPrice;

  final double finalTotal;

  final String payMethod;

  final OrderStatus status;

  final DateTime createdAt;

  final DateTime updatedAt;

  const OrderModel({
    required this.userId,
    required this.shippingAddress,
    required this.items,
    required this.totalPrice,
    required this.finalTotal,
    required this.payMethod,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> data) {
    final rawItems = data['items'] as List<dynamic>? ?? [];
    final items = rawItems
        .map((e) => OrderItemModel.fromMap(e as Map<String, dynamic>))
        .toList();

    final rawAddress = data['shipping_address'] as Map<String, dynamic>? ?? {};
    final shippingAddress = ShippingAddressModel.fromMap(rawAddress);

    DateTime toDateTime(dynamic value) {
      if (value is Timestamp) return value.toDate().toUtc();
      return DateTime.now().toUtc();
    }

    return OrderModel(
      userId: data['user_id'] as String? ?? '',
      shippingAddress: shippingAddress,
      items: items,
      totalPrice: (data['total_price'] as num?)?.toDouble() ?? 0.0,
      finalTotal: (data['final_total'] as num?)?.toDouble() ?? 0.0,
      payMethod: data['pay_method'] as String? ?? '',
      status: OrderStatusX.fromString(data['status'] as String? ?? ''),
      createdAt: toDateTime(data['created_at']),
      updatedAt: toDateTime(data['updated_at']),
    );
  }

  OrderEntity toEntity({required String orderId}) => OrderEntity(
    id: orderId,
    userId: userId,
    shippingAddress: shippingAddress.toEntity(),
    items: items.map((i) => i.toEntity()).toList(),
    totalPrice: totalPrice,
    finalTotal: finalTotal,
    payMethod: payMethod,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
