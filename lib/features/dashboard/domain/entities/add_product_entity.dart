class AddProductEntity {
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String? imageUrl;
  final bool isFeatured;
  final String code;

  const AddProductEntity({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.isFeatured,
    required this.code,
    this.imageUrl,
  });
}
