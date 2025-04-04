import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/core.dart';
import 'package:just_do_it_shop/pages/cart_page.dart';
import 'package:just_do_it_shop/pages/favorite_page.dart';
import 'package:just_do_it_shop/pages/home_page.dart';
import 'package:just_do_it_shop/pages/profile_page.dart';
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
        child: Column(
          children: [
            //TODO: put the nike logo image
            Center(
              child: Image.asset(
                "assets/images/nike_loo.png",
                color: Theme.of(context).colorScheme.primary,
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
                          "Home",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.info,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          "About",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //TODO: put logout
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GoogleNavBar(
        onTabChange: (index) => onTabChange(index),
      ),
      body: _pages[widget.selectedIndex],
    );
  }
}
