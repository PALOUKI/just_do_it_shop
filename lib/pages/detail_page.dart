import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:just_do_it_shop/core/core.dart';
import 'package:just_do_it_shop/widgets/detail_page/available_size.dart';
import '../providers/cart_provider.dart';
import '../models/Product.dart';
import '../providers/favorite_provider.dart';
import '../widgets/detail_page/available_color.dart';
import '../widgets/navigation.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    AppConfigSize.init(context);
    CartProvider cartProvider = CartProvider.of(context);
    final favoriteProvider = FavoriteProvider.of(context);
    final isExist = favoriteProvider.isExist(widget.product);

    void addClothToCart(Product product) {
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: getHeight(50)),
                      height: getHeight(220),
                      width: getWidth(220),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple.shade200,
                      ),
                      child: Image.asset(
                        widget.product.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: getHeight(30)),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(getSize(30)),
                      topRight: Radius.circular(getSize(30)),
                    ),
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: getWidth(3),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product.name.toUpperCase(),
                              style: AppTextStyles.headline3.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '\$${widget.product.price?.toStringAsFixed(2)}',
                              style: AppTextStyles.headline3.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: getSize(25),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //TODO: description of the model
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Text(
                          widget.product.description,
                          style: AppTextStyles.subtitle2.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      //TODO: size of the model
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Apprécier",
                                  style: AppTextStyles.headline3.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getHeight(4),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                    initialRating: 4,
                                    minRating: 1,
                                    itemSize: getSize(25),
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4),
                                    itemBuilder: (context, index)
                                    => Icon(
                                      Icons.star,
                                      color: Colors.yellowAccent,
                                    ),
                                    onRatingUpdate: (index){

                                    }
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Pointures disponibles",
                                  style: AppTextStyles.headline3.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AvailableSize(size: 'US 6'),
                                AvailableSize(size: 'US 7'),
                                AvailableSize(size: 'US 8'),
                                AvailableSize(size: 'US 9'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //TODO: color of the model
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Couleurs disponibles",
                                  style: AppTextStyles.headline3.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getHeight(10)),
                            Row(
                              children: [
                                AvailableColor(color: Colors.red),
                                SizedBox(width: getWidth(8)),
                                AvailableColor(color: Colors.green),
                                SizedBox(width: getWidth(8)),
                                AvailableColor(color: Colors.blue),
                                SizedBox(width: getWidth(8)),
                                AvailableColor(color: Colors.yellow),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //TODO: Button to retun to home page
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 15,
            child: Container(
              height: getHeight(40),
              width: getWidth(40),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 15,
            child: Container(
              height: getHeight(40),
              width: getWidth(40),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed:
                    () => favoriteProvider.toggleFavorites(widget.product),
                icon:
                    favoriteProvider.isExist(widget.product)
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.red,
                        ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(getSize(15)),
            topRight: Radius.circular(getSize(15)),
          ),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                  addClothToCart(widget.product);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      "Ajouter au panier",
                      style: AppTextStyles.subtitle1.copyWith(
                        color: Colors.white,
                        fontSize: getSize(20),
                      ),
                    ),
                    Icon(
                      Icons.shopping_cart_checkout,
                      color: Colors.white,
                      size: getSize(35),
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, RouteName.navigation, arguments: 2);
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                      size: getSize(35),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
