import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/core.dart';
import 'package:redacted/redacted.dart';

import '../models/Category.dart';
import '../models/Product.dart';
import '../services/supabase_service.dart';
import '../widgets/category_page/product_tile.dart';
import '../widgets/home_page/category_tile.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/see_all_products_page/filter_category_tile.dart';

class SeeAllProducts extends StatefulWidget {
  const SeeAllProducts({super.key});

  @override
  State<SeeAllProducts> createState() => _SeeAllProductsState();
}

class _SeeAllProductsState extends State<SeeAllProducts> {

  TextEditingController _searchController = TextEditingController();
  List<Category> _filteredCategories = [];
  List<Category> _categories = [];

  List<Product> _filteredProducts = [];
  List<Product> _products = [];
  bool _isLoading = false;




  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadProducts();
  }

  Future<void> _loadCategories() async {

    final categories = await SupabaseService.getCategories();
    setState(() {
      _categories = [
        Category(id: 'all', name: 'Tous', description: 'Tous les produits', imagePath: '', products: []),
        ...categories
      ];
      _filteredCategories = _categories;
    });

    setState(() {
      _isLoading = true;
    });
    try {
      final categories = await SupabaseService.getCategories();
      setState(() {
        _categories = categories;
        _filteredCategories = categories; // init affichage
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement des catégories: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final products = await SupabaseService.getProducts();
      setState(() {
        _products = products;
        _filteredProducts = products; // init affichage
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement des produits: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void filterProducts(String query) {
    final filtered = _products.where((product) {
      final nameLower = product.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredProducts = filtered;
    });
  }

  void sortByLowPrice() {
    final sortedProducts = List<Product>.from(_filteredProducts);
    sortedProducts.sort((a, b) => a.price.compareTo(b.price));
    print("Avant tri (bas): Premier prix = ${_filteredProducts.isNotEmpty ? _filteredProducts.first.price : 'Vide'}, Dernier prix = ${_filteredProducts.isNotEmpty ? _filteredProducts.last.price : 'Vide'}");
    setState(() {
      _filteredProducts = sortedProducts;
      print("Après tri (bas): Premier prix = ${_filteredProducts.isNotEmpty ? _filteredProducts.first.price : 'Vide'}, Dernier prix = ${_filteredProducts.isNotEmpty ? _filteredProducts.last.price : 'Vide'}");
    });
  }

  void sortByHighPrice() {
    final sortedProducts = List<Product>.from(_filteredProducts);
    sortedProducts.sort((a, b) => b.price.compareTo(a.price));
    print("Avant tri (haut): Premier prix = ${_filteredProducts.isNotEmpty ? _filteredProducts.first.price : 'Vide'}, Dernier prix = ${_filteredProducts.isNotEmpty ? _filteredProducts.last.price : 'Vide'}");
    setState(() {
      _filteredProducts = sortedProducts;
      print("Après tri (haut): Premier prix = ${_filteredProducts.isNotEmpty ? _filteredProducts.first.price : 'Vide'}, Dernier prix = ${_filteredProducts.isNotEmpty ? _filteredProducts.last.price : 'Vide'}");
    });
  }


  @override
  Widget build(BuildContext context) {
    AppConfigSize.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: getHeight(40), left: getHeight(15)),
              child: Text(
                  "Tous nos articles",
                style: AppTextStyles.subtitle1.copyWith(
                  color: Theme.of(context).colorScheme.tertiary
                ),
              ),
            ),

            //TODO Add filters
            _isLoading
                ? Container(
              margin: EdgeInsets.all(10),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Nombre fictif pour l'effet
                  itemBuilder: (context, index) => Container(
                    width: 100,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                  ).redacted(context: context, redact: true), // Appliquer ici
                ),
              ),
            )
                : _categories.isEmpty
                ? const Center(child: Text('Vous êtes hors connexion !!!"'))
                :
                Container(
                  margin: EdgeInsets.only(top: getHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          sortByLowPrice();
                        },
                        child: Container(
                          height: getHeight(50),
                          width: getWidth(160),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                            borderRadius: BorderRadius.circular(getSize(20))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_upward_outlined, color: Colors.white,),
                              Text(
                                "prix croissant",
                                  style: AppTextStyles.subtitle1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[100]
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:sortByHighPrice,
                        child: Container(
                          height: getHeight(50),
                          width: getWidth(160),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(getSize(20))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward_outlined, color: Colors.white,),
                              Text(
                                  "prix décroissant",
                                  style: AppTextStyles.subtitle1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[100]
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            Row(
              children: [
                Container(
                  height: getHeight(60),
                    width: getWidth(60),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepOrange,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Voir",
                            style: AppTextStyles.subtitle1.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: getSize(15),
                                color: Colors.grey[100]
                            )
                        ),
                        Text("tout",
                            style: AppTextStyles.subtitle1.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: getSize(15),
                                color: Colors.grey[100]
                            ),
                        ),
                      ],
                    )

                ),
                Expanded(
                  child: Container(
                    height: getHeight(70),
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            final selectedCategoryId = _filteredCategories[index].id;
                            setState(() {
                              if (selectedCategoryId == 'all') {
                                _filteredProducts = _products; // Afficher tous les produits
                              } else {
                                _filteredProducts = _products.where((product) {
                                  return product.categoryId == selectedCategoryId;
                                }).toList();
                              }
                            });
                          },

                          child: FilterCategoryTile(
                            categories: _filteredCategories,
                            index: index,
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 0);
                    },
                    ),
                  ),
                )
              ],
            ),

            //search part
            /*
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: getWidth(200),
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: filterProducts,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Rechercher",
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onTertiary, // Applique la couleur ici
                          ),
                        ),
                      ),
                    ).redacted(
                      context: context,
                      redact: true,
                      configuration: RedactedConfiguration(
                        animationDuration : const Duration(milliseconds: 2000), //default
                      ),
                    ),


                    const Icon(
                        Icons.search,
                        color: Colors.deepPurpleAccent
                    ),
                  ],
                ),
              ),
            ),

             */
            //search part
            // Utilisation du CustomSearchBar
            CustomSearchBar(
              isLoading: _isLoading,
              controller: _searchController,
              onChanged: filterProducts,
            ),


            _isLoading
              ? Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: 6, // Nombre fictif
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ).redacted( // Appliquer ici
                  context: context,
                  redact: true,
                ),
              ),
            )
              : _products.isEmpty
                  ? Expanded(child: Center(child: Text("Vous êtes hors connexion !!!"),))
                  : Expanded(
              child: Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Deux colonnes
                    crossAxisSpacing: 10, // Espacement horizontal
                    mainAxisSpacing: 10, // Espacement vertical
                    childAspectRatio: 0.75, // Proportion largeur/hauteur pour éviter les débordements
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
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
    );
  }
}
