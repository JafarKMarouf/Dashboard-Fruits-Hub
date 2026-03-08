import '../../domain/entities/add_product_entity.dart';

class ProductModel extends AddProductEntity {
  ProductModel({
    required super.name,
    required super.price,
    required super.quantity,
    required super.description,
    required super.isFeatured,
    required super.code,
    required super.imageFile,
    super.imageUrl,
    required super.expirationMonths,
    required super.numberOfCalories,
    required super.unitAmount,
    super.isOrganic,
    super.avgRate,
    super.countRate,
  });

  // ── Mapping ────────────────────────────────────────────────────────────────

  factory ProductModel.fromEntity(AddProductEntity entity) => ProductModel(
    name: entity.name,
    price: entity.price,
    quantity: entity.quantity,
    description: entity.description,
    imageUrl: entity.imageUrl,
    imageFile: entity.imageFile,
    isFeatured: entity.isFeatured,
    code: entity.code,
    expirationMonths: entity.expirationMonths,
    numberOfCalories: entity.numberOfCalories,
    unitAmount: entity.unitAmount,
    isOrganic: entity.isOrganic,
    avgRate: entity.avgRate,
    countRate: entity.countRate,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'quantity': quantity,
    'description': description,
    'image_url': imageUrl,
    'is_featured': isFeatured,
    'code': code,
    'expiration_months': expirationMonths,
    'number_of_calories': numberOfCalories,
    'unit_amount': unitAmount,
    'is_organic': isOrganic,
    'avg_rate': avgRate,
    'count_rate': countRate,
  };
}
