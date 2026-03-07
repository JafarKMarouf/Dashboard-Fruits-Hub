class ProductEntity {
  const ProductEntity({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.imageUrl,
    this.id,
  });

  final String? id;
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String imageUrl;
}
