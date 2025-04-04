import 'package:flutter/material.dart';
import 'package:just_do_it_shop/models/Product.dart';
import 'package:provider/provider.dart';

class CartProvider with ChangeNotifier{

  //List of items for sale

  //List of items in cart
  final List<Product> userCart = [];

  //get List of items in cart
  List<Product> getUserCart(){
    return userCart;
  }

  //add item in cart
  void addItemToCart(Product item){
    userCart.add(item);
    notifyListeners();
  }

  //remove item from cart
  void removeItemFromCart(Product item){
    userCart.remove(item);
    notifyListeners();
  }

  void toggleCartProducts(Product product){
    if(userCart.contains(product)){
      for(product in userCart){
        product.quantity++;
      }
    }else{
      userCart.add(product);
    }
    notifyListeners();
  }

   incrementQuantity(int index) => userCart[index].quantity++;
   decrementQuantity(int index) => userCart[index].quantity--;

  // get the total price
  double get getTotalPrice {
    double total = 0;
    for (var item in userCart) {
      if (item.price != null) {
        total += item.price! * item.quantity;
      }
    }
    return total;
  }

  static CartProvider of(BuildContext context, {
    listen = false
  }){
    return Provider.of<CartProvider>(context, listen: listen);
  }


}