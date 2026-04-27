import '../../../../core/entities/order_entity/order_entity.dart';

abstract class DashboardRepo {
  Stream<List<OrderEntity>> watchOrders();
}
