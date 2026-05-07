import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/customer_entity.dart';
import '../../../../../core/enums/customer_status.dart';
import '../../../domain/repos/customers_repo.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit(this._repo) : super(const CustomersInitialState());

  final CustomersRepo _repo;

  StreamSubscription<List<CustomerEntity>>? _sub;
  List<CustomerEntity> _all = [];
  String _query = '';

  CustomerStatus _activeFilter = CustomerStatus.all;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  void startWatching() {
    if (_sub != null) return;
    emit(const CustomersLoadingState());

    _sub = _repo.watchCustomers().listen((customers) {
      _all = customers;
      _emitFiltered();
    }, onError: (e) => emit(CustomersFailureState(e.toString())));
  }

  // ── Search ─────────────────────────────────────────────────────────────────

  void search(String query) {
    _query = query.trim().toLowerCase();
    _emitFiltered();
  }

  void clearSearch() {
    _query = '';
    _emitFiltered();
  }

  // ── Filter ─────────────────────────────────────────────────────────────────

  void filterByStatus(CustomerStatus status) {
    _activeFilter = status;
    _emitFiltered();
  }

  // ── Status update ──────────────────────────────────────────────────────────

  Future<void> updateStatus({
    required String customerId,
    required CustomerStatus status,
  }) async {
    try {
      await _repo.updateCustomerStatus(customerId: customerId, status: status);
    } catch (_) {
      emit(CustomersUpdateFailureState(customerId));
      _emitFiltered();
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  int countByStatus(CustomerStatus status) => status == CustomerStatus.all
      ? _all.length
      : _all.where((c) => c.status == status).length;

  void _emitFiltered() {
    var result = _activeFilter == CustomerStatus.all
        ? _all
        : _all.where((c) => c.status == _activeFilter).toList();

    if (_query.isNotEmpty) {
      result = result
          .where(
            (c) =>
                c.name.toLowerCase().contains(_query) ||
                c.email.toLowerCase().contains(_query),
          )
          .toList();
    }

    emit(
      CustomersLoadedState(
        customers: result,
        totalCount: _all.length,
        activeFilter: _activeFilter,
      ),
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
