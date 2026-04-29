import 'dart:developer';

import 'package:dashboard_fruit_hub/core/services/database_service/database_service.dart';
import 'package:dashboard_fruit_hub/core/utils/backend_endpoints.dart';
import 'package:dashboard_fruit_hub/features/inventory/domain/entities/inventory_entity.dart';

import '../../domain/repos/inventory_repo.dart';
import '../models/inventory_model.dart';

class InventoryRepoImpl implements InventoryRepo {
  const InventoryRepoImpl(this._db);

  final DatabaseService _db;
  InventoryEntity _build(Map<String, dynamic> data, String id) =>
      InventoryModel.fromJson(data, id).toEntity();

  @override
  Stream<List<InventoryEntity>> watchProducts() {
    return _db.watchData<InventoryEntity>(
      path: BackendEndpoints.getProduct,
      query: {'orderBy': 'name', 'descending': false},
      builder: _build,
    );
  }

  @override
  Future<void> restockProduct({
    required String productId,
    required int newQuantity,
  }) async {
    try {
      await _db.updateData(
        path: BackendEndpoints.updateProduct,
        documentId: productId,
        data: {'quantity': newQuantity},
      );
    } catch (e) {
      log('InventoryRepoImpl.restockProduct: $e');
      rethrow;
    }
  }
}
