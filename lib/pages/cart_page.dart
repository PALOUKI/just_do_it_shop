import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/core.dart';
import 'package:just_do_it_shop/providers/cart_provider.dart';
import 'package:just_do_it_shop/models/Product.dart';
import '../widgets/cart_page/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = CartProvider.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            "Mon panier",
            style: AppTextStyles.headline2.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 2,
          child: ListView.builder(
            itemCount: cartProvider.getUserCart().length,
            itemBuilder: (context, index) {
              //get individual clothItem
              Product product = cartProvider.getUserCart()[index];

              //return the cart item
              return CartItem(
                product: product,
                incrementQuantity: (index) {
                  setState(() {
                    cartProvider.incrementQuantity(index);
                  });
                },
                decrementQuantity: (index) {
                  setState(() {
                    cartProvider.decrementQuantity(index);
                  });
                },
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(10),
                //border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Text(
                cartProvider.getTotalPrice.toStringAsFixed(2),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
