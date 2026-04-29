import 'dart:async';

import 'package:dashboard_fruit_hub/features/inventory/domain/entities/inventory_entity.dart';
import 'package:dashboard_fruit_hub/features/inventory/domain/repos/inventory_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit(this._repo) : super(InventoryInitialState());

  final InventoryRepo _repo;

  StreamSubscription<List<InventoryEntity>>? _sub;
  List<InventoryEntity> _all = [];
  String _query = '';

  void startWatching() {
    if (_sub != null) return;
    emit(InventoryLoadingState());

    _sub = _repo.watchProducts().listen((products) {
      _all = products;
      _emitFiltered();
    }, onError: (e) => emit(InventoryFailureState(e.toString())));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }

  // ── Search ────────────────────────────────────────────────────────────────
  void search(String query) {
    _query = query.trim().toLowerCase();
    _emitFiltered();
  }

  void clearSearch() {
    _query = '';
    _emitFiltered();
  }
  // ── Restock ───────────────────────────────────────────────────────────────

  Future<void> restock({
    required String productId,
    required int addQuantity,
  }) async {
    final current = _all.firstWhere((p) => p.id == productId);
    final newQty = current.quantity + addQuantity;

    try {
      await _repo.restockProduct(productId: productId, newQuantity: newQty);
    } catch (_) {
      emit(InventoryRestockFailureState(productId));
      _emitFiltered();
    }
  }

  void _emitFiltered() {
    final filtered = _query.isEmpty
        ? _all
        : _all
              .where(
                (p) =>
                    p.name.toLowerCase().contains(_query) ||
                    p.code.toLowerCase().contains(_query),
              )
              .toList();

    emit(InventoryLoadedState(products: filtered, totalCount: _all.length));
  }
}
