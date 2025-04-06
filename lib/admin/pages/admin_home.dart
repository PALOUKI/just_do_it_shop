import 'package:flutter/material.dart';
import '../../core/core.dart';
import 'category_management.dart';
import 'product_management.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                  'Administration',
                style: AppTextStyles.headline2.copyWith(
                  color: Theme.of(context).colorScheme.tertiary
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Gérer les catégories'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(context, RouteName.adminNavigation, arguments: 1);
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: const Text('Gérer les produits'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pushNamed(context, RouteName.adminNavigation, arguments: 2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
