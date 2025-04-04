abstract class Product{
  final String imagePath;
  final String name;
  final String description;
    int quantity = 1;
  final double? price;
  final bool? inStock;

  Product({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.quantity,
    this.price,
    this.inStock
  });

}