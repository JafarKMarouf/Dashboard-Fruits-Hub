import 'package:equatable/equatable.dart';

import '../../../../../core/entities/order_entity/order_entity.dart';

// ─── Filter ────────────────────────────────────────────────────────────────

enum OrderFilter { all, pending, shipped, delivered, cancelled }

extension OrderFilterX on OrderFilter {
  String get labelAr {
    switch (this) {
      case OrderFilter.all:
        return 'الكل';
      case OrderFilter.pending:
        return 'قيد الانتظار';
      case OrderFilter.shipped:
        return 'قيد الشحن';
      case OrderFilter.delivered:
        return 'تم التسليم';
      case OrderFilter.cancelled:
        return 'ملغى';
    }
  }
}

// ─── States ────────────────────────────────────────────────────────────────

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitialState extends OrdersState {
  const OrdersInitialState();
}

class OrdersLoadingState extends OrdersState {
  const OrdersLoadingState();
}

class OrdersLoadedState extends OrdersState {
  final List<OrderEntity> orders;
  final List<OrderEntity> filtered;
  final OrderFilter activeFilter;
  final String? updatingOrderId;
  const OrdersLoadedState({
    required this.orders,
    required this.filtered,
    required this.activeFilter,
    this.updatingOrderId,
  });

  OrdersLoadedState copyWith({
    List<OrderEntity>? orders,
    List<OrderEntity>? filtered,
    OrderFilter? activeFilter,
    String? updatingOrderId,
    bool clearUpdating = false,
  }) {
    return OrdersLoadedState(
      orders: orders ?? this.orders,
      filtered: filtered ?? this.filtered,
      activeFilter: activeFilter ?? this.activeFilter,
      updatingOrderId: clearUpdating
          ? null
          : (updatingOrderId ?? this.updatingOrderId),
    );
  }

  @override
  List<Object?> get props => [orders, filtered, activeFilter, updatingOrderId];
}

class OrdersFailureState extends OrdersState {
  final String message;

  const OrdersFailureState(this.message);
}

class OrderStatusUpdateError extends OrdersState {
  final String message;
  final List<OrderEntity> orders;
  final List<OrderEntity> filtered;
  final OrderFilter activeFilter;

  const OrderStatusUpdateError({
    required this.message,
    required this.orders,
    required this.filtered,
    required this.activeFilter,
  });

  @override
  List<Object?> get props => [message, orders, filtered, activeFilter];
}
