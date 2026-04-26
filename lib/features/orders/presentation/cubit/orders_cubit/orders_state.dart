import 'package:equatable/equatable.dart';

import '../../../domain/entities/order_entity.dart';

// ─── Filter ────────────────────────────────────────────────────────────────

enum OrderFilter { all, pending, shipped, delivered }

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
    }
  }
}

// ─── States ────────────────────────────────────────────────────────────────

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading();
}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;
  final List<OrderEntity> filtered;
  final OrderFilter activeFilter;
  final String? updatingOrderId;
  const OrdersLoaded({
    required this.orders,
    required this.filtered,
    required this.activeFilter,
    this.updatingOrderId,
  });

  OrdersLoaded copyWith({
    List<OrderEntity>? orders,
    List<OrderEntity>? filtered,
    OrderFilter? activeFilter,
    String? updatingOrderId,
    bool clearUpdating = false,
  }) {
    return OrdersLoaded(
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

class OrdersError extends OrdersState {
  final String message;

  const OrdersError(this.message);

  @override
  List<Object?> get props => [message];
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
