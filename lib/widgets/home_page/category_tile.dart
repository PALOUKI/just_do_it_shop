import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/core.dart';
import '../../models/Category.dart';

class CategoryTile extends StatelessWidget {
  final List<Category> categories;
  final int index; // Ajout de l'index pour gérer les couleurs dynamiques
  final List<Color> colors = [ Colors.deepPurpleAccent, Colors.green, Colors.orange, Colors.blue,];

   CategoryTile({
    super.key,
    required this.categories,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    AppConfigSize.init(context);
    return Container(
      width: 200,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colors[index % colors.length],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image de la catégorie
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                categories[index].imagePath,
                fit: BoxFit.cover,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: Icon(Icons.error_outline, color: Colors.grey[500]),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 150,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Nom de la catégorie
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              categories[index].name,
              style: AppTextStyles.headline3.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[100]
              )
            ),
          ),
          // Description de la catégorie
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              categories[index].description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
