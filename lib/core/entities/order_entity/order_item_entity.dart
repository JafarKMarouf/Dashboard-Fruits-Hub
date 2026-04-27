class OrderItemEntity {
  final String productCode;
  final String productName;
  final String? imageUrl;
  final int quantity;
  final double priceAtPurchase;

  const OrderItemEntity({
    required this.productCode,
    required this.productName,
    this.imageUrl,
    required this.quantity,
    required this.priceAtPurchase,
  });

  double get lineTotal => quantity * priceAtPurchase;
}
