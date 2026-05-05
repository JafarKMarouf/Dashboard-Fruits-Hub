import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/customer_entity.dart';
import '../../../../core/enums/customer_status.dart';

class CustomerModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final CustomerStatus status;
  final Timestamp? createdAt;

  const CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    this.createdAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      status: CustomerStatusX.fromString(json['status'] as String? ?? 'active'),
      createdAt: _parseTimestamp(json['created_at']),
    );
  }
  static Timestamp? _parseTimestamp(dynamic value) {
    if (value == null) return null;

    if (value is Timestamp) {
      return value;
    }

    if (value is String) {
      try {
        return Timestamp.fromDate(DateTime.parse(value));
      } catch (e) {
        log('Error parsing date string: $e');
        return null;
      }
    }

    return null;
  }

  CustomerEntity toEntity() => CustomerEntity(
    id: id,
    name: name,
    email: email,
    status: status,
    role: role,
    createdAt: createdAt,
  );

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'name': name,
      'email': email,
      'status': status,
      'role': role,
      'created_at': createdAt,
    };
  }
}
