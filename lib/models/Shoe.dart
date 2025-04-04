import 'package:just_do_it_shop/models/Product.dart';

class Shoe extends Product{

     final double price;
     final bool inStock;

     Shoe({
       required super.name,
       required super.imagePath,
       required super.description,
       required super.quantity,
       required this.price,
       required this.inStock
    });

}