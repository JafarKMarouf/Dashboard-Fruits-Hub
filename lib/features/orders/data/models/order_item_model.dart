import '../../domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.productCode,
    required super.productName,
    super.imageUrl,
    required super.quantity,
    required super.priceAtPurchase,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      productCode: map['product_code'] as String? ?? '',
      productName: map['product_name'] as String? ?? '',
      imageUrl: map['image_url'] as String?,
      priceAtPurchase: (map['price_at_purchase'] as num?)?.toDouble() ?? 0.0,
      quantity: (map['count'] as num?)?.toInt() ?? 1,
    );
  }

  Map<String, dynamic> toMap() => {
    'product_code': productCode,
    'product_name': productName,
    'image_url': imageUrl,
    'count': quantity,
    'price_at_purchase': priceAtPurchase,
  };
}
