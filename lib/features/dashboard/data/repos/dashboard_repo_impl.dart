import 'package:dashboard_fruit_hub/core/entities/order_entity/order_entity.dart';
import 'package:dashboard_fruit_hub/features/dashboard/domain/repos/dashboard_repo.dart';

import '../../../../core/services/database/database_service.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../../../orders/data/models/order_model.dart';

class DashboardRepoImpl extends DashboardRepo {
  final DatabaseService databaseService;

  DashboardRepoImpl(this.databaseService);
  OrderEntity _build(Map<String, dynamic> data, String id) =>
      OrderModel.fromJson(data).toEntity(orderId: id);

  @override
  Stream<List<OrderEntity>> watchRecentOrders({int limit = 10}) {
    return databaseService.watchData<OrderEntity>(
      path: BackendEndpoints.getOrder,
      query: {'orderBy': 'created_at', 'descending': true, 'limit': limit},
      builder: _build,
    );
  }

  @override
  Stream<List<OrderEntity>> watchAllOrdersForStats() {
    return databaseService.watchData<OrderEntity>(
      path: BackendEndpoints.getOrder,
      query: {'orderBy': 'created_at', 'descending': true},
      builder: _build,
    );
  }
}
