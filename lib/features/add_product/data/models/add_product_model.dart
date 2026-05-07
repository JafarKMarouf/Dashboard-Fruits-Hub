import '../../domain/entities/add_product_entity.dart';

class AddProductModel {
  final AddProductEntity _entity;

  const AddProductModel(this._entity);

  Map<String, dynamic> toJson() {
    return {
      'name': _entity.name,
      'price': _entity.price,
      'quantity': _entity.quantity,
      'description': _entity.description,
      'image_url': _entity.imageUrl,
      'is_featured': _entity.isFeatured,
      'code': _entity.code,
      'expiration_months': _entity.expirationMonths,
      'number_of_calories': _entity.numberOfCalories,
      'unit_amount': _entity.unitAmount,
      'is_organic': _entity.isOrganic,
      'avg_rate': 0,
      'count_rate': 0,
      'selling_count': 0,
      'reviews': [],
    };
  }
}
