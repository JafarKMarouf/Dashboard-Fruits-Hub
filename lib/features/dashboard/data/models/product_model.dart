import 'package:dashboard_fruit_hub/features/dashboard/data/models/review_model.dart';

import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String name;
  final double price;
  final int quantity;
  final String description;
  String? imageUrl;
  final bool isFeatured;
  final String code;
  final int expirationMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final int unitAmount;
  final num avgRate;
  final num countRate;
  final int sellingCount;
  final List<ReviewModel> reviews;

  ProductModel({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.isFeatured,
    required this.code,
    this.imageUrl,
    required this.expirationMonths,
    required this.numberOfCalories,
    required this.unitAmount,
    this.isOrganic = false,
    this.avgRate = 0,
    this.countRate = 0,
    this.sellingCount = 0,
    required this.reviews,
  });

  // ── Mapping ────────────────────────────────────────────────────────────────

  factory ProductModel.fromEntity(ProductEntity entity) => ProductModel(
    name: entity.name,
    price: entity.price,
    quantity: entity.quantity,
    description: entity.description,
    imageUrl: entity.imageUrl,
    isFeatured: entity.isFeatured,
    code: entity.code,
    expirationMonths: entity.expirationMonths,
    numberOfCalories: entity.numberOfCalories,
    unitAmount: entity.unitAmount,
    isOrganic: entity.isOrganic,
    avgRate: entity.avgRate,
    countRate: entity.countRate,
    reviews: entity.reviews
        .map((review) => ReviewModel.fromEntity(review))
        .toList(),
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
    'selling_count': sellingCount,
    'reviews': reviews.map((review) => review.toJson()).toList(),
  };
}
