import 'package:flutter/material.dart';
import 'package:just_do_it_shop/models/Product.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';
import '../../providers/cart_provider.dart';

class CartItem extends StatefulWidget {
  Product product;
  void Function(int)? incrementQuantity;
  void Function(int)? decrementQuantity;

   CartItem({
      super.key,
      required this.product,
      required this.incrementQuantity,
      required this.decrementQuantity
   });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  void removeItemFromCart(){
    Provider.of<CartProvider>(context, listen: false).removeItemFromCart(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    AppConfigSize.init(context);
    return Container(
        margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            leading: Image.asset(
                widget.product.imagePath,
              fit: BoxFit.cover,
            ),
            title: Text(
                widget.product.name,
              style: AppTextStyles.subtitle1.copyWith(
                color: Colors.grey[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                    '\$${widget.product.price!.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyText1.copyWith(
                      color: Colors.grey.shade500,
                    fontWeight: FontWeight.w500,
                  ),
                  /*TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                
                   */
                ),
                SizedBox(width: getWidth(40),),
                Text(
                    "x${widget.product.quantity.toString()}",
                  style: AppTextStyles.subtitle2.copyWith(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
           trailing: SizedBox(
             width: 105,
             child: Column(
               children: [
                 Row(
                   children: [
                     IconButton(
                         onPressed: (){
                           widget.incrementQuantity;
                         },
                         icon: Icon(Icons.add, color: Colors.deepOrangeAccent, size: getSize(20),)
                     ),
                     Text(
                         widget.product.quantity.toString(),
                       style: AppTextStyles.bodyText1.copyWith(
                         fontWeight: FontWeight.bold
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(bottom: 8.0),
                       child: IconButton(
                           onPressed: (){
                             widget.decrementQuantity;
                           },
                           icon: Icon(Icons.minimize_rounded, color: Colors.redAccent, size: getSize(20),)
                       ),
                     ),
                   ],
                 ),
               
               ],
             ),
           ),



           /* trailing: IconButton(
                onPressed: removeItemFromCart,
                icon: Icon(Icons.delete_outline_outlined, color: Colors.purple,)
            ),

            */
          ),
        ),
      );
  }
}
