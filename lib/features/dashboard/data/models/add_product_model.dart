import '../../domain/entities/add_product_entity.dart';

class ProductModel extends AddProductEntity {
  const ProductModel({
    required super.name,
    required super.price,
    required super.quantity,
    required super.description,
    required super.isFeatured,
    required super.code,
    super.imageUrl,
  });

  // ── Mapping ────────────────────────────────────────────────────────────────

  factory ProductModel.fromEntity(AddProductEntity entity) => ProductModel(
    name: entity.name,
    price: entity.price,
    quantity: entity.quantity,
    description: entity.description,
    imageUrl: entity.imageUrl,
    isFeatured: entity.isFeatured,
    code: entity.code,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    quantity: json['quantity'] as int,
    description: json['description'] as String,
    imageUrl: json['image_url'] as String,
    isFeatured: json['is_featured'] as bool,
    code: json['code'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'quantity': quantity,
    'description': description,
    'image_url': imageUrl,
    'is_featured': isFeatured,
    'code': code,
  };
}
