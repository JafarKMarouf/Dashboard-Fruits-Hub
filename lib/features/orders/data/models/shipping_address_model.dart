import '../../domain/entities/shipping_address_entity.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  const ShippingAddressModel({
    required super.name,
    required super.phone,
    required super.email,
    required super.city,
    required super.state,
  });

  factory ShippingAddressModel.fromMap(Map<String, dynamic> map) {
    return ShippingAddressModel(
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      email: map['email'] as String? ?? '',
      city: map['city'] as String? ?? '',
      state: map['state'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'email': email,
    'city': city,
    'state': state,
  };
}
