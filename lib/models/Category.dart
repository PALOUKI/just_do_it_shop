import 'package:just_do_it_shop/models/Product.dart';


class Category {
  final String imagePath;
  final String name;
  final String description;
  final List<Product> products;

  Category({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.products,
  });
}