import 'package:dashboard_fruit_hub/core/entities/order_entity/order_item_entity.dart';

class OrderItemModel {
  final String productCode;
  final String productName;
  final String? imageUrl;
  final int quantity;
  final double priceAtPurchase;

  const OrderItemModel({
    required this.productCode,
    required this.productName,
    this.imageUrl,
    required this.quantity,
    required this.priceAtPurchase,
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

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      productCode: productCode,
      productName: productName,
      quantity: quantity,
      priceAtPurchase: priceAtPurchase,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_code': productCode,
      'product_name': productName,
      'image_url': imageUrl,
      'price_at_purchase': priceAtPurchase,
      'count': quantity,
    };
  }
}
