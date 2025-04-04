import 'package:flutter/material.dart';
import 'package:just_do_it_shop/models/Product.dart';

import '../../core/core.dart';

class FavoriteItem extends StatefulWidget {

  final Product product;
  final void Function() onPressed;

  const FavoriteItem({super.key, required this.product, required this.onPressed});

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
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
          subtitle: Text(
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
          trailing: IconButton(
              onPressed: widget.onPressed,
              icon: Icon(Icons.remove_red_eye, color: Colors.grey[900],)
          ),


        ),
      ),
    );
  }
}
