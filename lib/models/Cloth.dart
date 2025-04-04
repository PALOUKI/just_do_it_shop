import 'package:just_do_it_shop/models/Product.dart';

class Cloth extends Product{

  final double price;
  final bool inStock;


  Cloth({
    required super.name,
    required super.imagePath,
    required super.description,
    required super.quantity,
    required this.price,
    required this.inStock
  });

}