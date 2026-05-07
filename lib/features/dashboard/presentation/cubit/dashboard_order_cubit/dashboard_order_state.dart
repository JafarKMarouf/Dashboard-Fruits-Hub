part of 'dashboard_order_cubit.dart';

sealed class DashboardOrderState {
  const DashboardOrderState();
}

final class DashboardOrderInitial extends DashboardOrderState {}

final class DashboardOrderLoading extends DashboardOrderState {}

final class DashboardOrderLoaded extends DashboardOrderState {
  final List<OrderEntity> allOrders;
  final List<OrderEntity> recentOrders;
  const DashboardOrderLoaded({
    required this.recentOrders,
    required this.allOrders,
  });

  double get totalRevenue => allOrders
      .where((o) => o.status != OrderStatus.cancelled)
      .fold(0.0, (sum, o) => sum + o.finalTotal);

  int get totalOrdersCount => allOrders.length;

  int get pendingCount => _count(OrderStatus.pending);
  int get shippedCount => _count(OrderStatus.shipped);
  int get deliveredCount => _count(OrderStatus.delivered);
  int get cancelledCount => _count(OrderStatus.cancelled);

  int get activeOrdersCount =>
      allOrders.where((o) => o.status != OrderStatus.cancelled).length;

  int _count(OrderStatus s) => allOrders.where((o) => o.status == s).length;
}

final class DashboardOrderFailure extends DashboardOrderState {
  final String message;
  DashboardOrderFailure(this.message);
}
