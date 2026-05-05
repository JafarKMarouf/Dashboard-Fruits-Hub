class InventoryEntity {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;
  final int unitAmount;
  final int sellingCount;
  final bool isOrganic;
  final String code;

  const InventoryEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
    required this.unitAmount,
    required this.sellingCount,
    required this.isOrganic,
    required this.code,
  });

  static const int lowStockThreshold = 10;

  bool get isLowStock => quantity < lowStockThreshold;
}
