import 'dart:io';

import 'package:dashboard_fruit_hub/features/dashboard/domain/entities/review_entity.dart';

class ProductEntity {
  final String name;
  final double price;
  final int quantity;
  final String description;
  final File imageFile;
  String? imageUrl;
  final bool isFeatured;
  final String code;
  final int expirationMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final int unitAmount;
  final num avgRate;
  final num countRate;
  final List<ReviewEntity> reviews;

  ProductEntity({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.isFeatured,
    required this.code,
    required this.imageFile,
    this.imageUrl,
    required this.expirationMonths,
    this.isOrganic = false,
    required this.numberOfCalories,
    required this.unitAmount,
    this.avgRate = 0,
    this.countRate = 0,
    required this.reviews,
  });
}
