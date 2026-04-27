import 'order_item_entity.dart';
import 'order_status.dart';
import 'shipping_address_entity.dart';

class OrderEntity {
  final String? id;

  final String? userId;

  final ShippingAddressEntity? shippingAddress;

  final List<OrderItemEntity>? items;

  final double? totalPrice;

  final double finalTotal;

  final String? payMethod;

  final OrderStatus status;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  const OrderEntity({
    this.id,
    this.userId,
    this.shippingAddress,
    this.items,
    this.totalPrice,
    required this.finalTotal,
    this.payMethod,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  int get totalQuantity => items!.fold(0, (sum, i) => sum + i.quantity);
}
