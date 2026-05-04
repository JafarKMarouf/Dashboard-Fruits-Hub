import 'package:dashboard_fruit_hub/core/enums/order_status.dart';

import '../../../../core/entities/order_entity/order_entity.dart';

abstract class OrdersRepo {
  Stream<List<OrderEntity>> watchOrders();

  Future<OrderEntity> getOrderById(String orderId);

  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  });
}
