import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/core.dart';
import 'package:just_do_it_shop/pages/cart_page.dart';
import 'package:just_do_it_shop/pages/favorite_page.dart';
import 'package:just_do_it_shop/pages/home_page.dart';
import 'package:just_do_it_shop/pages/profile_page.dart';
import 'package:just_do_it_shop/providers/auth_provider.dart';
import 'package:just_do_it_shop/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'google_nav_bar.dart';

class Navigation extends StatefulWidget {
  int selectedIndex = 0;
  Navigation({super.key, required this.selectedIndex});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  //var _selectedIndex = 0;

  void onTabChange(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  List _pages = [HomePage(), FavoritePage(), CartPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = ThemeProvider.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return Container(
              //padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(10),
                /*boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 5,
                        spreadRadius: 1
                    )
                  ]

                   */
              ),
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.sort,
                  color: Theme.of(context).colorScheme.primary,
                  size: getSize(30),
                ),
              ),
            );
          },
        ),
        actions: [
          Container(
            //padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(10),
              /* boxShadow: themeProvider.isLightTheme ? [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 5,
                  spreadRadius: 1
                )
              ] : []

              */
            ),
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.notifications,
                color: Theme.of(context).colorScheme.primary,
                size: getSize(30),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(Icons.wb_sunny_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            final bool isAuthenticated = auth.isAuthenticated;
            final user = auth.currentUser;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // En-tête avec seulement le logo
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.deepPurpleAccent,
                    child: Center(
                      child: Image.asset(
                        "assets/images/nike_loo.png",
                        color: Theme.of(context).colorScheme.secondary,
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                ),

                // Email centré uniquement si connecté
                if (isAuthenticated)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Center(
                      child: Text(
                        user?.email ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                // Contenu principal
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Liste des options avec défilement
                      Expanded(
                        child: ListView(
                          children: [
                            // Nom d'utilisateur en première position si connecté
                           /*
                            if (isAuthenticated)
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  (user?.fullName != null && user!.fullName.isNotEmpty)
                                    ? user.fullName
                                    : 'Utilisateur',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),

                            */
                            // Options communes
                            ListTile(
                              leading: Icon(
                                Icons.home_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: Text("Accueil"),
                              onTap: () {
                                Navigator.pop(context);
                                onTabChange(0);
                              },
                            ),

                            // Option Mon Profil uniquement si connecté
                            if (isAuthenticated)
                              ListTile(
                                leading: Icon(
                                  Icons.person_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text("Mon Profil"),
                                onTap: () {
                                  Navigator.pop(context);
                                  onTabChange(3);
                                },
                              ),

                            // À propos pour tous
                            ListTile(
                              leading: Icon(
                                Icons.info_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: Text("À propos"),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),

                      // Divider avant le bouton du bas
                      Divider(),

                      // Bouton du bas: Déconnexion OU Connexion
                      if (isAuthenticated)
                        ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          title: Text(
                            "Déconnexion",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          onTap: () {
                            auth.signOut();
                            Navigator.pop(context);
                          },
                        )
                      else
                        ListTile(
                          leading: Icon(
                            Icons.person_add_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          title: Text("Créer un compte"),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, RouteName.login);
                          },
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: GoogleNavBar(
        selectedIndex: widget.selectedIndex,
        onTabChange: (index) => onTabChange(index),
      ),
      body: _pages[widget.selectedIndex],
    );
  }
}
