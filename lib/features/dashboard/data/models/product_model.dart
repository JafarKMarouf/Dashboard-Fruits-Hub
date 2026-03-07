import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.name,
    required super.price,
    required super.quantity,
    required super.description,
    required super.imageUrl,
    super.id,
  });

  // ── Mapping ────────────────────────────────────────────────────────────────

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    id: entity.id,
    name: entity.name,
    price: entity.price,
    quantity: entity.quantity,
    description: entity.description,
    imageUrl: entity.imageUrl,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as String?,
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    quantity: json['quantity'] as int,
    description: json['description'] as String,
    imageUrl: json['image_url'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'quantity': quantity,
    'description': description,
    'image_url': imageUrl,
  };
}
