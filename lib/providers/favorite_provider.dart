import 'package:flutter/material.dart';
import 'package:just_do_it_shop/models/Product.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier{
  // List of favorites items
  final List<Product>  favoriteProducts = [];

  //get favoritesItems
  List<Product> getFavoritesItems(){
    return favoriteProducts;
  }

  //add or remove to favorites
  void toggleFavorites(Product product){
    if(favoriteProducts.contains(product)){
      favoriteProducts.remove(product);
    }else{
      favoriteProducts.add(product);
    }
    notifyListeners();
  }

  bool isExist(Product product){
    final isExist = favoriteProducts.contains(product);
    return isExist;
  }

  static FavoriteProvider of(BuildContext context, {
    bool listen = true,
  }){
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }

}