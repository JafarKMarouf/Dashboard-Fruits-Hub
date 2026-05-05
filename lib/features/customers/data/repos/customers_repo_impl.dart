import 'dart:developer';

import 'package:dashboard_fruit_hub/features/customers/domain/entities/customer_entity.dart';
import 'package:dashboard_fruit_hub/core/enums/customer_status.dart';
import 'package:dashboard_fruit_hub/features/customers/domain/repos/customers_repo.dart';

import '../../../../core/services/database_service/database_service.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../models/customer_model.dart';

class CustomersRepoImpl implements CustomersRepo {
  const CustomersRepoImpl(this._db);

  final DatabaseService _db;

  CustomerEntity _build(Map<String, dynamic> data, String id) =>
      CustomerModel.fromJson(data).toEntity();

  @override
  Stream<List<CustomerEntity>> watchCustomers() {
    return _db.watchData<CustomerEntity>(
      path: BackendEndpoints.getUser,
      query: {
        'where': [
          {'field': 'role', 'isEqualTo': 'customer'},
        ],
        'orderBy': 'created_at',
        'descending': true,
      },
      builder: _build,
    );
  }

  @override
  Future<void> updateCustomerStatus({
    required String customerId,
    required CustomerStatus status,
  }) async {
    try {
      await _db.updateData(
        path: BackendEndpoints.updateUser,
        documentId: customerId,
        data: {'status': status.value},
      );
    } catch (e) {
      log('CustomersRepoImpl.updateCustomerStatus: $e');
      rethrow;
    }
  }
}
