import 'dart:io';

class AddProductEntity {
  final String name;
  final double price;
  final int quantity;
  final String description;
  final bool isFeatured;
  final String code;
  final int expirationMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final int unitAmount;
  final File imageFile;
  String? imageUrl;

  AddProductEntity({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.isFeatured,
    required this.code,
    required this.expirationMonths,
    required this.isOrganic,
    required this.numberOfCalories,
    required this.unitAmount,
    required this.imageFile,
    this.imageUrl,
  });
}
