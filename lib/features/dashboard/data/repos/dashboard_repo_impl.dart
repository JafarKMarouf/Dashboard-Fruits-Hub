import 'package:dashboard_fruit_hub/core/entities/order_entity/order_entity.dart';
import 'package:dashboard_fruit_hub/features/dashboard/domain/repos/dashboard_repo.dart';

import '../../../../core/services/database_service/database_service.dart';
import '../../../../core/utils/backend_endpoints.dart';
import '../../../orders/data/models/order_model.dart';

class DashboardRepoImpl extends DashboardRepo {
  final DatabaseService databaseService;

  DashboardRepoImpl(this.databaseService);

  static const int _pageLimit = 10;

  @override
  Stream<List<OrderEntity>> watchOrders() {
    return databaseService.watchData<OrderEntity>(
      path: BackendEndpoints.getOrder,
      query: {'orderBy': 'created_at', 'descending': true, 'limit': _pageLimit},
      builder: (data, id) => OrderModel.fromJson(data).toEntity(orderId: id),
    );
  }
}
