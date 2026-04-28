import '../../../../core/entities/order_entity/shipping_address_entity.dart';

class ShippingAddressModel {
  final String name;
  final String phone;
  final String email;
  final String city;
  final String state;
  const ShippingAddressModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.city,
    required this.state,
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

  ShippingAddressEntity toEntity() => ShippingAddressEntity(
    name: name,
    phone: phone,
    email: email,
    city: city,
    state: state,
  );
}
