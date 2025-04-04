import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/appConfigSize.dart';
import 'package:just_do_it_shop/core/core.dart';
import 'package:just_do_it_shop/widgets/category_page//product_tile.dart';
import '../models/Category.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {



  @override
  Widget build(BuildContext context) {
    AppConfigSize.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Stack(
                  children: [
                    Image.asset(
                      widget.category.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: getHeight(300),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: getHeight(120),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.category.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              widget.category.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //TODO: make clothes items GridView.builder
              Expanded(
                child: Container(
                  color: Colors.grey.shade200,
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Deux colonnes
                      crossAxisSpacing: 10, // Espacement horizontal
                      mainAxisSpacing: 10, // Espacement vertical
                      childAspectRatio: 0.75, // Proportion largeur/hauteur pour éviter les débordements
                    ),
                    itemCount: widget.category.products.length,
                    itemBuilder: (context, index) {
                      final product = widget.category.products[index];
                      return ProductTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context,
                                RouteName.detailPage,
                              arguments: product
                            );

                          },
                          //onPressed: () => addClothToCart(clothItem)
                          product: product
                      );

                    },
                  ),
                ),
              )

            ],
          ),
          //TODO: Button to retun to home page
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteName.homePage,
                  arguments: 0,
                );
              },
              child: Container(
                height: getHeight(40),
                width: getWidth(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
