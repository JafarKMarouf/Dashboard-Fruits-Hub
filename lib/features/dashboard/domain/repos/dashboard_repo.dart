import '../../../../core/entities/order_entity/order_entity.dart';

abstract class DashboardRepo {
  Stream<List<OrderEntity>> watchRecentOrders({int limit = 10});
  Stream<List<OrderEntity>> watchAllOrdersForStats();
}
