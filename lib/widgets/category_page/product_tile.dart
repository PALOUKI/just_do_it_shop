import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/appStyles.dart';
import 'package:just_do_it_shop/models/Product.dart';
import 'package:just_do_it_shop/providers/favorite_provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final void Function()? onTap;

  const ProductTile({
    super.key,
    required this.product,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {

    final provider = FavoriteProvider.of(context);
    final isExist = provider.isExist(product);


    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Container(
                    height: 150, // Hauteur fixe pour l'image
                    width: double.infinity,
                    child: Image.asset(
                      product.imagePath,
                      fit: BoxFit.contain, // Ajustement pour éviter les débordements
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    color: Colors.black54.withOpacity(0.7),
                    child: Text(
                      product.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 8,
                  child: IconButton(
                    onPressed: () => provider.toggleFavorites(product),
                    icon: provider.isExist(product) ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border_outlined, color: Colors.red,)
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if(product.inStock)
                    Text(
                        "En Stock",
                      style: AppTextStyles.subtitle1.copyWith(
                        color: Theme.of(context).colorScheme.primary
                      ),
                    ),
                  if(!product.inStock)
                    Text("Stock épuisé"),
                ],
              ),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //if (clothItem is Shoe || clothItem is Cloth || clothItem is Accessory)
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.subtitle2.copyWith(
                        color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                ],
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.purple,
                    ),
                  ),

                ],
              ),
            ),

             */
          ],
        ),
      ),
    );
  }
}
