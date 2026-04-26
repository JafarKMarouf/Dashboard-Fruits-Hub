import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/order_entity.dart';
import 'order_item_model.dart';
import 'shipping_address_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.customerName,
    required super.shippingAddress,
    required super.items,
    required super.totalPrice,
    required super.finalTotal,
    required super.payMethod,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory OrderModel.fromDoc(DocumentSnapshot doc, {String? customerName}) {
    final data = doc.data() as Map<String, dynamic>;

    final rawItems = data['items'] as List<dynamic>? ?? [];
    final items = rawItems
        .map((e) => OrderItemModel.fromMap(e as Map<String, dynamic>))
        .toList();

    final rawAddress = data['shipping_address'] as Map<String, dynamic>? ?? {};
    final shippingAddress = ShippingAddressModel.fromMap(rawAddress);

    DateTime toDateTime(dynamic value) {
      if (value is Timestamp) return value.toDate();
      return DateTime.now();
    }

    return OrderModel(
      id: doc.id,
      userId: data['user_id'] as String? ?? '',
      customerName: customerName ?? shippingAddress.name,
      shippingAddress: shippingAddress,
      items: items,
      totalPrice: (data['total_price'] as num?)?.toDouble() ?? 0.0,
      finalTotal: (data['final_total'] as num?)?.toDouble() ?? 0.0,
      payMethod: data['pay_method'] as String? ?? '',
      status: OrderStatusX.fromString(data['status'] as String? ?? ''),
      createdAt: toDateTime(data['created_at']),
      updatedAt: toDateTime(data['updatedAt']),
    );
  }

  OrderModel copyWith({String? customerName}) => OrderModel(
    id: id,
    userId: userId,
    customerName: customerName ?? this.customerName,
    shippingAddress: shippingAddress,
    items: items,
    totalPrice: totalPrice,
    finalTotal: finalTotal,
    payMethod: payMethod,
    status: status,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  Map<String, dynamic> toMap() => {
    'user_id': userId,
    'shipping_address': ShippingAddressModel(
      name: shippingAddress.name,
      phone: shippingAddress.phone,
      email: shippingAddress.email,
      city: shippingAddress.city,
      state: shippingAddress.state,
    ).toMap(),
    'items': items
        .map(
          (i) => OrderItemModel(
            productCode: i.productCode,
            productName: i.productName,
            imageUrl: i.imageUrl,
            quantity: i.quantity,
            priceAtPurchase: i.priceAtPurchase,
          ).toMap(),
        )
        .toList(),
    'total_price': totalPrice,
    'final_total': finalTotal,
    'pay_method': payMethod,
    'status': status.name,
    'created_at': Timestamp.fromDate(createdAt),
    'updatedAt': FieldValue.serverTimestamp(),
  };
}
