import 'dart:async';

import 'package:dashboard_fruit_hub/features/dashboard/domain/repos/dashboard_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/entities/order_entity/order_entity.dart';

part 'dashboard_order_state.dart';

class DashboardOrderCubit extends Cubit<DashboardOrderState> {
  StreamSubscription<List<OrderEntity>>? _subscription;

  bool get isWatching => _subscription != null;
  final DashboardRepo dashboardRepo;

  DashboardOrderCubit(this.dashboardRepo) : super(DashboardOrderInitial());

  void startWatching() {
    if (_subscription != null) return;

    emit(DashboardOrderLoading());

    _subscription = dashboardRepo.watchOrders().listen(
      _onOrdersReceived,
      onError: (e) => emit(DashboardOrderFailure(e.toString())),
    );
  }

  void _onOrdersReceived(List<OrderEntity> orders) {
    emit(DashboardOrderLoaded(orders));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
