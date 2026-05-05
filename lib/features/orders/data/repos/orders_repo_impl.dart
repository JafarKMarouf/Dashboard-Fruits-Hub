import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_fruit_hub/core/services/database_service/database_service.dart';
import 'package:dashboard_fruit_hub/core/enums/order_status.dart';

import '../../../../core/utils/backend_endpoints.dart';
import '../../../../core/entities/order_entity/order_entity.dart';
import '../../domain/repos/orders_repo.dart';
import '../models/order_model.dart';

class OrdersRepoImpl implements OrdersRepo {
  final DatabaseService databaseService;

  OrdersRepoImpl(this.databaseService);

  @override
  Stream<List<OrderEntity>> watchOrders() {
    return databaseService.watchData<OrderEntity>(
      path: BackendEndpoints.getOrder,
      query: {'orderBy': 'created_at', 'descending': true},
      builder: (data, id) => OrderModel.fromJson(data).toEntity(orderId: id),
    );
  }

  @override
  Future<OrderEntity> getOrderById(String orderId) async {
    final doc = await databaseService.getData(
      path: BackendEndpoints.getOrder,
      documentId: orderId,
    );
    return OrderModel.fromJson(
      doc,
    ).toEntity(orderId: doc['id'] as String? ?? orderId);
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    await databaseService.updateData(
      path: BackendEndpoints.getOrder,
      documentId: orderId,
      data: {'status': status.name, 'updated_at': FieldValue.serverTimestamp()},
    );
  }
}
