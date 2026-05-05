import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/enums/customer_status.dart';

class CustomerEntity {
  final String id;
  final String name;
  final String email;
  final String role;
  final CustomerStatus status;
  final Timestamp? createdAt;

  const CustomerEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    this.createdAt,
  });

  String get initials => name.isNotEmpty ? name[0].toUpperCase() : '?';
}
