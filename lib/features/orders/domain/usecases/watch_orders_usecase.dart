import '../entities/order_entity.dart';
import '../repos/orders_repo.dart';

class WatchOrdersUseCase {
  final OrdersRepo _repo;
  const WatchOrdersUseCase(this._repo);

  Stream<List<OrderEntity>> call() => _repo.watchOrders();
}
