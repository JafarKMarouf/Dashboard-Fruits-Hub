import 'package:dashboard_fruit_hub/core/entities/order_entity/order_status.dart';

import '../repos/orders_repo.dart';

class UpdateOrderStatusUseCase {
  final OrdersRepo _repo;

  const UpdateOrderStatusUseCase(this._repo);

  Future<void> call({required String orderId, required OrderStatus status}) =>
      _repo.updateOrderStatus(orderId: orderId, status: status);
}
