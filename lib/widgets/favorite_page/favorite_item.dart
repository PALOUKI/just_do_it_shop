import 'package:flutter/material.dart';
import 'package:just_do_it_shop/models/Product.dart';
import 'package:just_do_it_shop/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../../core/core.dart';

class FavoriteItem extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;

  const FavoriteItem({
    super.key,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context);
    void addProductToCart(Product product) {
      cartProvider.toggleCartProducts(product);
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
          title: Text("Ajouter avec succès"),
          content: Text("Vérifiez votre panier"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  RouteName.navigation,
                  arguments: 2,
                );
              },
              child: Text('Panier'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ok'),
            ),
          ],
        ),
      );

    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image dans un cercle violet
            SizedBox(
              height: 70,
              width: 70,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Positioned(
                    top: -8,
                    left: -8,
                    right: -8,
                    bottom: -8,
                    child: Image.asset(
                      product.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: getWidth(40)),

            // Infos produit
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.headline3.copyWith(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),
                  Text(
                    '\$${product.price!.toStringAsFixed(2)}',
                    style: AppTextStyles.subtitle1.copyWith(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Icone Add to Cart
            IconButton(
              onPressed: () {
                // Tu peux appeler ici une méthode pour ajouter au panier
                addProductToCart(product);
              },
              icon: Icon(Icons.add_shopping_cart),
              color: Theme.of(context).colorScheme.onPrimary,
              tooltip: "Ajouter au panier",
            ),
          ],
        ),
      ),
    );
  }
}
