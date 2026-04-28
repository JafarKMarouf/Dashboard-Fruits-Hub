import 'dart:async';

import 'package:dashboard_fruit_hub/core/entities/order_entity/order_status.dart';
import 'package:dashboard_fruit_hub/features/dashboard/domain/repos/dashboard_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/entities/order_entity/order_entity.dart';

part 'dashboard_order_state.dart';

class DashboardOrderCubit extends Cubit<DashboardOrderState> {
  final DashboardRepo dashboardRepo;

  StreamSubscription<List<OrderEntity>>? _recentSub;
  StreamSubscription<List<OrderEntity>>? _statsSub;

  List<OrderEntity> _recentOrders = [];
  List<OrderEntity> _allOrdersForStats = [];

  bool get isWatching => _recentSub != null;

  DashboardOrderCubit(this.dashboardRepo) : super(DashboardOrderInitial());

  void startWatching() {
    if (_recentSub != null) return;

    emit(DashboardOrderLoading());

    _recentSub = dashboardRepo.watchRecentOrders().listen((orders) {
      _recentOrders = orders;
      _emitLoaded();
    }, onError: (e) => emit(DashboardOrderFailure(e.toString())));

    _statsSub = dashboardRepo.watchAllOrdersForStats().listen((orders) {
      _allOrdersForStats = orders;
      _emitLoaded();
    }, onError: (_) {});
  }

  void _emitLoaded() {
    emit(
      DashboardOrderLoaded(
        recentOrders: _recentOrders,
        allOrders: _allOrdersForStats,
      ),
    );
  }

  @override
  Future<void> close() {
    _recentSub?.cancel();
    _statsSub?.cancel();
    return super.close();
  }
}
