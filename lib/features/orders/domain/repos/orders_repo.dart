import '../entities/order_entity.dart';

abstract class OrdersRepo {
  /// Real-time stream of all orders, newest first.
  Stream<List<OrderEntity>> watchOrders();

  /// Fetch a single order by [orderId].
  Future<OrderEntity> getOrderById(String orderId);

  // /// Update order status. Returns updated entity on success.
  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  });
}
