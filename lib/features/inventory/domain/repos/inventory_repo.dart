import 'package:dashboard_fruit_hub/features/inventory/domain/entities/inventory_entity.dart';

abstract class InventoryRepo {
  Stream<List<InventoryEntity>> watchProducts();

  Future<void> restockProduct({
    required String productId,
    required int newQuantity,
  });
}
