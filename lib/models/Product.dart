class Product {
  final String? id;
  final String imagePath;
  final String name;
  final String description;
  final int quantity;
  final double price;
  final bool inStock;
  final String categoryId;

  Product({
    this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.inStock,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'image_path': imagePath,
    'name': name,
    'description': description,
    'quantity': quantity,
    'price': price,
    'in_stock': inStock,
    'category_id': categoryId,
  };
}