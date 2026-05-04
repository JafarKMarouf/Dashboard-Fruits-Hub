import 'dart:async';

import 'package:dashboard_fruit_hub/core/enums/order_status.dart';
import 'package:dashboard_fruit_hub/features/orders/domain/repos/orders_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/order_entity/order_entity.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.ordersRepo) : super(const OrdersInitialState());

  final OrdersRepo ordersRepo;

  StreamSubscription<List<OrderEntity>>? _subscription;
  bool get isWatching => _subscription != null;

  List<OrderEntity> _all = [];

  // Default is .all — never null; no more null-bang crashes.
  OrderStatus _activeFilter = OrderStatus.all;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  void startWatching() {
    if (_subscription != null) return;
    emit(const OrdersLoadingState());

    _subscription = ordersRepo.watchOrders().listen((orders) {
      _all = orders;
      _emitFiltered();
    }, onError: (e) => emit(OrdersFailureState(e.toString())));
  }

  // ── Filter ─────────────────────────────────────────────────────────────────

  /// Switch to [filter]. Passing [OrderStatus.all] shows every order.
  void filterByStatus(OrderStatus filter) {
    _activeFilter = filter;
    _emitFiltered();
  }

  // ── Status update ──────────────────────────────────────────────────────────

  Future<void> updateStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    if (state is! OrdersLoadedState) return;
    final current = state as OrdersLoadedState;

    // Optimistically flag the row as updating.
    emit(current.copyWith(updatingOrderId: orderId));

    try {
      await ordersRepo.updateOrderStatus(orderId: orderId, status: status);
      // Stream will push a fresh list automatically; just clear the flag.
      if (state is OrdersLoadedState) {
        emit((state as OrdersLoadedState).copyWith(clearUpdating: true));
      }
    } catch (e) {
      emit(
        OrdersUpdateFailureState(
          all: current.all,
          filtered: current.filtered,
          activeFilter: current.activeFilter,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// Count of orders for [status] across the full (unfiltered) list.
  int countByStatus(OrderStatus status) => status == OrderStatus.all
      ? _all.length
      : _all.where((o) => o.status == status).length;

  void _emitFiltered() {
    final filtered = _activeFilter == OrderStatus.all
        ? _all
        : _all.where((o) => o.status == _activeFilter).toList();

    emit(
      OrdersLoadedState(
        all: _all,
        filtered: filtered,
        activeFilter: _activeFilter,
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
