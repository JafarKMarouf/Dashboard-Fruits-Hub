import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/customer_entity.dart';
import '../../../../core/enums/customer_status.dart';

class CustomerModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final CustomerStatus status;
  final String? imageUrl;
  final Timestamp? createdAt;

  const CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    this.imageUrl,
    this.createdAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      status: CustomerStatusX.fromString(json['status'] as String? ?? 'active'),
      createdAt: json['created_at'] as Timestamp?,
      imageUrl: json['image_url'] as String?,
    );
  }

  CustomerEntity toEntity() => CustomerEntity(
    id: id,
    name: name,
    email: email,
    status: status,
    role: role,
    createdAt: createdAt,
    imageUrl: imageUrl,
  );

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'name': name,
      'email': email,
      'status': status,
      'role': role,
      'image_url': imageUrl,
      'created_at': createdAt,
    };
  }
}
