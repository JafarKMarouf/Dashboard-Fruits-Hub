import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecases/update_order_status_usecase.dart';
import '../../../domain/usecases/watch_orders_usecase.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final WatchOrdersUseCase _watchOrders;
  final UpdateOrderStatusUseCase _updateStatus;

  StreamSubscription<List<OrderEntity>>? _subscription;

  bool get isWatching => _subscription != null;

  OrdersCubit({
    required WatchOrdersUseCase watchOrders,
    required UpdateOrderStatusUseCase updateStatus,
  }) : _watchOrders = watchOrders,
       _updateStatus = updateStatus,
       super(const OrdersInitial());

  void startWatching() {
    if (_subscription != null) return;

    emit(const OrdersLoading());

    _subscription = _watchOrders().listen(
      _onOrdersReceived,
      onError: (e) => emit(OrdersError(e.toString())),
    );
  }

  void _onOrdersReceived(List<OrderEntity> orders) {
    final currentFilter = state is OrdersLoaded
        ? (state as OrdersLoaded).activeFilter
        : OrderFilter.all;

    emit(
      OrdersLoaded(
        orders: orders,
        filtered: _applyFilter(orders, currentFilter),
        activeFilter: currentFilter,
      ),
    );
  }

  void setFilter(OrderFilter filter) {
    if (state is! OrdersLoaded) return;
    final loaded = state as OrdersLoaded;

    emit(
      loaded.copyWith(
        activeFilter: filter,
        filtered: _applyFilter(loaded.orders, filter),
      ),
    );
  }

  List<OrderEntity> _applyFilter(List<OrderEntity> orders, OrderFilter filter) {
    switch (filter) {
      case OrderFilter.all:
        return orders;
      case OrderFilter.pending:
        return orders.where((o) => o.status == OrderStatus.pending).toList();
      case OrderFilter.shipped:
        return orders.where((o) => o.status == OrderStatus.shipped).toList();
      case OrderFilter.delivered:
        return orders.where((o) => o.status == OrderStatus.delivered).toList();
    }
  }

  Future<void> updateStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    if (state is! OrdersLoaded) return;
    final loaded = state as OrdersLoaded;

    emit(loaded.copyWith(updatingOrderId: orderId));

    try {
      await _updateStatus(orderId: orderId, status: status);
      if (state is OrdersLoaded) {
        emit((state as OrdersLoaded).copyWith(clearUpdating: true));
      }
    } catch (e) {
      emit(
        OrderStatusUpdateError(
          message: e.toString(),
          orders: loaded.orders,
          filtered: loaded.filtered,
          activeFilter: loaded.activeFilter,
        ),
      );
    }
  }

  int countByStatus(OrderStatus status) {
    if (state is! OrdersLoaded) return 0;
    return (state as OrdersLoaded).orders
        .where((o) => o.status == status)
        .length;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
