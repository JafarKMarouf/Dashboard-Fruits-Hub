import 'package:dashboard_fruit_hub/features/orders/domain/entities/order_status.dart';

import '../repos/orders_repo.dart';

class UpdateOrderStatusUseCase {
  final OrdersRepo _repo;

  const UpdateOrderStatusUseCase(this._repo);

  Future<void> call({required String orderId, required OrderStatus status}) =>
      _repo.updateOrderStatus(orderId: orderId, status: status);
}
