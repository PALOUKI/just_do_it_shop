import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/core.dart';
import 'package:just_do_it_shop/widgets/home_page/category_tile.dart';
import 'package:just_do_it_shop/widgets/home_page/news_section.dart';
import '../models/Category.dart';
import '../services/supabase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _searchController = TextEditingController();
  List<Category> _filteredCategories = [];
  List<Category> _categories = [];
  bool _isLoading = false;



  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
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

  void filterCategories(String query) {
    final filtered = _categories.where((category) {
      final nameLower = category.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredCategories = filtered;
    });
  }


  @override
  Widget build(BuildContext context) {
    AppConfigSize.init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        onChanged: filterCategories,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Rechercher",
                          hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                        ),
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
            const SizedBox(height: 10),
            Text(
              "Everyone flies... Some fly longer than others",
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coup de coeur 🔥",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    "Voir tout",
                    style: TextStyle(color: Colors.deepPurpleAccent)
                  ),
                ],
              ),
            ),
        
        
        
            const NewsSection(),
        
        
        
            
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Catégories",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _categories.isEmpty
                    ? const Center(child: Text('Aucune catégorie disponible'))
                    :
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredCategories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteName.categoryPage,
                        arguments: _filteredCategories[index],
                      );
                    },
                    child: CategoryTile(
                      categories: _filteredCategories,
                      index: index,
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10,);
            },
            ),
          ],
        ),
      ),
    );
  }
}
