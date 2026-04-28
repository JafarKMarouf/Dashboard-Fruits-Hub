import 'dart:async';

import 'package:dashboard_fruit_hub/core/entities/order_entity/order_status.dart';
import 'package:dashboard_fruit_hub/features/orders/domain/repos/orders_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/order_entity/order_entity.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  StreamSubscription<List<OrderEntity>>? _subscription;

  bool get isWatching => _subscription != null;

  final OrdersRepo ordersRepo;
  OrdersCubit(this.ordersRepo) : super(const OrdersInitialState());

  void startWatching() {
    if (_subscription != null) return;

    emit(const OrdersLoadingState());

    _subscription = ordersRepo.watchOrders().listen(
      _onOrdersReceived,
      onError: (e) => emit(OrdersFailureState(e.toString())),
    );
  }

  void _onOrdersReceived(List<OrderEntity> orders) {
    final currentFilter = state is OrdersLoadedState
        ? (state as OrdersLoadedState).activeFilter
        : OrderFilter.all;

    emit(
      OrdersLoadedState(
        orders: orders,
        filtered: _applyFilter(orders, currentFilter),
        activeFilter: currentFilter,
      ),
    );
  }

  void setFilter(OrderFilter filter) {
    if (state is! OrdersLoadedState) return;
    final loaded = state as OrdersLoadedState;

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
      case OrderFilter.cancelled:
        return orders.where((o) => o.status == OrderStatus.cancelled).toList();
    }
  }

  Future<void> updateStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    if (state is! OrdersLoadedState) return;
    final loaded = state as OrdersLoadedState;

    emit(loaded.copyWith(updatingOrderId: orderId));

    try {
      await ordersRepo.updateOrderStatus(orderId: orderId, status: status);
      if (state is OrdersLoadedState) {
        emit((state as OrdersLoadedState).copyWith(clearUpdating: true));
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
    if (state is! OrdersLoadedState) return 0;
    return (state as OrdersLoadedState).orders
        .where((o) => o.status == status)
        .length;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
