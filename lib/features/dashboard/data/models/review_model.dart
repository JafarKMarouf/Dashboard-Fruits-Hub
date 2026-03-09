import 'package:dashboard_fruit_hub/features/dashboard/domain/entities/review_entity.dart';

class ReviewModel {
  final String customerName;
  final String customerImage;
  final num ratting;
  final String description;
  final String date;

  ReviewModel({
    required this.customerName,
    required this.customerImage,
    required this.ratting,
    required this.description,
    required this.date,
  });

  // ── Mapping ────────────────────────────────────────────────────────────────

  factory ReviewModel.fromEntity(ReviewEntity entity) => ReviewModel(
    customerName: entity.customerName,
    customerImage: entity.customerImage,
    ratting: entity.ratting,
    description: entity.description,
    date: entity.date,
  );

  Map<String, dynamic> toJson() => {
    'customer_name': customerName,
    'customer_image': customerImage,
    'ratting': ratting,
    'description': description,
    'date': date,
  };
}
