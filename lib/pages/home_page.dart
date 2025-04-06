import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/core.dart';
import 'package:just_do_it_shop/models/Cloth.dart';
import 'package:just_do_it_shop/widgets/home_page/category_tile.dart';
import 'package:just_do_it_shop/widgets/home_page/news_section.dart';
import '../models/Category.dart';
import '../models/Shoe.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.orange];

  final List<Category> categories = [
    Category(
      name: 'Chaussures',
      imagePath: AssetsConstants.shoes,
      description:
          'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
      products: [
        Shoe(
          name: 'Air Jordan',
          imagePath: AssetsConstants.shoe1,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: true,
        ),
        Shoe(
          name: 'Chaussure',
          imagePath: AssetsConstants.shoe2,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: true,
        ),
        Shoe(
          name: 'Chaussure',
          imagePath: AssetsConstants.shoe3,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: true,
        ),
        Shoe(
          name: 'Chaussure',
          imagePath: AssetsConstants.shoe4,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: true,
        ),
      ],
    ),
    Category(
      name: 'Vêtements',
      imagePath: AssetsConstants.clothes,
      description:
          'Complétez votre style. \nDes accessoires tendance qui apportent la touche finale à votre look.',
      products: [
        Cloth(
          name: 'habit',
          imagePath: AssetsConstants.cloth1,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: true,
        ),
        Cloth(
          name: 'habit',
          imagePath: AssetsConstants.cloth2,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: true,
        ),
        Cloth(
          name: 'habit',
          imagePath: AssetsConstants.cloth3,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: true,
        ),
        Cloth(
          name: 'habit',
          imagePath: AssetsConstants.cloth4,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: true,
        ),
      ],
    ),
    Category(
      name: 'Accessoires',
      imagePath: AssetsConstants.accessoires,
      description:
          'Équipement pour vos performances. \nDécouvrez notre sélection de matériel conçu pour maximiser vos résultats.',
      products: [
        Cloth(
          name: 'Accessoire',
          imagePath: AssetsConstants.acs1,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: false,
        ),
        Cloth(
          name: 'Accessoire',
          imagePath: AssetsConstants.acs2,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: false,
        ),
        Cloth(
          name: 'Accessoire',
          imagePath: AssetsConstants.acs3,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: false,
        ),
        Cloth(
          name: 'Accessoire',
          imagePath: AssetsConstants.acs4,
          description:
              'Mode et confort pour chaque jour. \nDes vêtements qui allient style et praticité pour toutes les occasions.',
          price: 200,
          quantity: 1,
          inStock: false,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    AppConfigSize.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  Container(
                    width: getWidth(200),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Rechercher",
                        hintStyle: TextStyle(
                          color: Colors.deepPurpleAccent
                        ),
                      ),
                    ),
                  ),

                  Icon(
                      Icons.search,
                      color: Colors.deepPurpleAccent
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Text(
              "Everyone flies... Some fly longer than others",
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coup de coeur 🔥 ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text("Voir tout", style: TextStyle(color: Colors.deepPurpleAccent)),
                ],
              ),
            ),
          ),
          NewsSection(),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cathégories ## ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //TODO: make listView of shoes
          Expanded(
            child: Container(
              //margin: EdgeInsets.all(15),
              child: ListView.builder(
                //scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.categoryPage,
                        arguments: categories[index],
                      );
                    },
                    child: CategoryTile(categories: categories, index: index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
