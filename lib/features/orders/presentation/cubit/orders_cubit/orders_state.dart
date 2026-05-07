import '../../../../../core/entities/order_entity/order_entity.dart';
import '../../../../../core/enums/order_status.dart';

abstract class OrdersState {
  const OrdersState();
}

class OrdersInitialState extends OrdersState {
  const OrdersInitialState();
}

class OrdersLoadingState extends OrdersState {
  const OrdersLoadingState();
}

class OrdersLoadedState extends OrdersState {
  final List<OrderEntity> all;

  final List<OrderEntity> filtered;

  final OrderStatus activeFilter;

  final String? updatingOrderId;

  const OrdersLoadedState({
    required this.all,
    required this.filtered,
    required this.activeFilter,
    this.updatingOrderId,
  });

  int countByStatus(OrderStatus status) => status == OrderStatus.all
      ? all.length
      : all.where((o) => o.status == status).length;

  OrdersLoadedState copyWith({
    List<OrderEntity>? all,
    List<OrderEntity>? filtered,
    OrderStatus? activeFilter,
    String? updatingOrderId,
    bool clearUpdating = false,
  }) {
    return OrdersLoadedState(
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      activeFilter: activeFilter ?? this.activeFilter,
      updatingOrderId: clearUpdating
          ? null
          : (updatingOrderId ?? this.updatingOrderId),
    );
  }
}

class OrdersFailureState extends OrdersState {
  final String message;
  const OrdersFailureState(this.message);
}

class OrdersUpdateFailureState extends OrdersLoadedState {
  final String errorMessage;

  const OrdersUpdateFailureState({
    required super.all,
    required super.filtered,
    required super.activeFilter,
    required this.errorMessage,
  });
}
