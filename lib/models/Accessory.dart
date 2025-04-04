import 'package:just_do_it_shop/models/Product.dart';

class Accessory extends Product{

  final double price;


  Accessory({
    required super.name,
    required super.imagePath,
    required super.description,
    required super.quantity,
    required this.price,
  });

}