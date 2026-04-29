import '../../domain/entities/inventory_entity.dart';

class InventoryModel {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;
  final int unitAmount;
  final int sellingCount;
  final bool isOrganic;
  final String code;

  const InventoryModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
    required this.unitAmount,
    required this.sellingCount,
    required this.isOrganic,
    required this.code,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json, String id) {
    return InventoryModel(
      id: id,
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      imageUrl: json['image_url'] as String?,
      unitAmount: (json['unit_amount'] as num?)?.toInt() ?? 0,
      sellingCount: (json['selling_count'] as num?)?.toInt() ?? 0,
      isOrganic: json['is_organic'] as bool? ?? false,
      code: json['code'] as String? ?? '',
    );
  }

  InventoryEntity toEntity() {
    return InventoryEntity(
      id: id,
      name: name,
      price: price,
      quantity: quantity,
      imageUrl: imageUrl,
      unitAmount: unitAmount,
      sellingCount: sellingCount,
      isOrganic: isOrganic,
      code: code,
    );
  }
}
