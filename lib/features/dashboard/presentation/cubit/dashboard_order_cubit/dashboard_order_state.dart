part of 'dashboard_order_cubit.dart';

sealed class DashboardOrderState {
  const DashboardOrderState();
}

final class DashboardOrderInitial extends DashboardOrderState {}

final class DashboardOrderLoading extends DashboardOrderState {}

final class DashboardOrderLoaded extends DashboardOrderState {
  final List<OrderEntity> orders;

  const DashboardOrderLoaded(this.orders);
}

final class DashboardOrderFailure extends DashboardOrderState {
  final String message;
  DashboardOrderFailure(this.message);
}
