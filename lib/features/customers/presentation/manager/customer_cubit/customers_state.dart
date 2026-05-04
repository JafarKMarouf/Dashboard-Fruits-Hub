part of 'customers_cubit.dart';

sealed class CustomersState {
  const CustomersState();
}

final class CustomersInitialState extends CustomersState {
  const CustomersInitialState();
}

final class CustomersLoadingState extends CustomersState {
  const CustomersLoadingState();
}

final class CustomersLoadedState extends CustomersState {
  final List<CustomerEntity> customers;

  final int totalCount;

  final CustomerStatus activeFilter;

  const CustomersLoadedState({
    required this.customers,
    required this.totalCount,
    required this.activeFilter,
  });

  int countByStatus(List<CustomerEntity> all, CustomerStatus status) =>
      status == CustomerStatus.all
      ? all.length
      : all.where((c) => c.status == status).length;

  CustomersLoadedState copyWith({
    List<CustomerEntity>? customers,
    int? totalCount,
    CustomerStatus? activeFilter,
  }) {
    return CustomersLoadedState(
      customers: customers ?? this.customers,
      totalCount: totalCount ?? this.totalCount,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }
}

final class CustomersUpdateFailureState extends CustomersState {
  final String customerId;
  const CustomersUpdateFailureState(this.customerId);
}

final class CustomersFailureState extends CustomersState {
  final String message;
  const CustomersFailureState(this.message);
}
