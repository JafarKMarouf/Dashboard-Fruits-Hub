import 'order_item_entity.dart';
import 'shipping_address_entity.dart';

enum OrderStatus { pending, shipped, delivered, cancelled }

extension OrderStatusX on OrderStatus {
  String get labelAr {
    switch (this) {
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.shipped:
        return 'تم الشحن';
      case OrderStatus.delivered:
        return 'تم التسليم';
      case OrderStatus.cancelled:
        return 'ملغي';
    }
  }

  static OrderStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }
}

// ─── Order Entity ──────────────────────────────────────────────────────────

class OrderEntity {
  final String id;

  final String userId;

  final String customerName;

  final ShippingAddressEntity shippingAddress;

  final List<OrderItemEntity> items;

  final double totalPrice;

  final double finalTotal;

  final String payMethod;

  final OrderStatus status;

  final DateTime createdAt;

  final DateTime updatedAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.customerName,
    required this.shippingAddress,
    required this.items,
    required this.totalPrice,
    required this.finalTotal,
    required this.payMethod,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String get displayNumber =>
      'رقم الطلب #${id.length >= 4 ? id.substring(0, 4).toUpperCase() : id}';

  int get totalQuantity => items.fold(0, (sum, i) => sum + i.quantity);
}
