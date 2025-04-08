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
            return Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/nike_loo.png",
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      if (auth.isAuthenticated) ...[  
                        const SizedBox(height: 16),
                        Text(
                          auth.currentUser?.fullName ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          auth.currentUser?.email ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.home,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              "Accueil",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              onTabChange(0);
                            },
                          ),
                          if (auth.isAuthenticated) ...[  
                            ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: Text(
                                "Mon Profil",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                onTabChange(3);
                              },
                            ),
                          ],
                          ListTile(
                            leading: Icon(
                              Icons.info,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              "À propos",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      if (auth.isAuthenticated)
                        ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          title: Text(
                            "Déconnexion",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
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
                            Icons.login,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          title: Text(
                            "Connexion",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
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
