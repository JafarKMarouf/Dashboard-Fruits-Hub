part of 'inventory_cubit.dart';

sealed class InventoryState {
  const InventoryState();
}

final class InventoryInitialState extends InventoryState {}

final class InventoryLoadingState extends InventoryState {}

final class InventoryLoadedState extends InventoryState {
  final List<InventoryEntity> products;

  final int totalCount;

  const InventoryLoadedState({
    required this.products,
    required this.totalCount,
  });

  int get lowStockCount => products.where((p) => p.isLowStock).length;
}

final class InventoryRestockFailureState extends InventoryState {
  final String productId;
  const InventoryRestockFailureState(this.productId);
}

final class InventoryFailureState extends InventoryState {
  final String message;
  const InventoryFailureState(this.message);
}
