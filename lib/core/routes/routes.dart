import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/routes/routes_names.dart';
import 'package:just_do_it_shop/models/Product.dart';
import 'package:just_do_it_shop/pages/detail_page.dart';
import 'package:just_do_it_shop/pages/home_page.dart';
import 'package:just_do_it_shop/pages/category_page.dart';

import '../../admin/pages/admin_intro_page.dart';
import '../../admin/widgets/admin_navigation.dart';
import '../../models/Category.dart';
import '../../pages/auth/login_page.dart';
import '../../pages/auth/signup_page.dart';
import '../../pages/cart_page.dart';
import '../../pages/intro_page.dart';
import '../../pages/profile_page.dart';
import '../../widgets/navigation.dart';



class Routes{

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings){

    switch(routeSettings.name){
      case RouteName.introPage:
        return MaterialPageRoute(builder: (_) => const IntroPage());
      case RouteName.navigation:
        final int selectedIndex = routeSettings.arguments as int;
        return MaterialPageRoute(builder: (_) =>  Navigation(selectedIndex: selectedIndex,));
      case RouteName.cartPage:
        return MaterialPageRoute(builder: (_) => const CartPage());
      case RouteName.categoryPage:
        final category = routeSettings.arguments as Category;
        return MaterialPageRoute(
          builder: (_) => CategoryPage(
            category: category,
          ),
        );
      case RouteName.detailPage:
        final product = routeSettings.arguments as Product;
        return MaterialPageRoute(
          builder: (_) => DetailPage(
            product: product,
          ),
        );
      
      // Auth routes
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteName.signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case RouteName.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      
      // Admin routes
      case RouteName.adminNavigation:
        final int selectedIndex = routeSettings.arguments as int;
        return MaterialPageRoute(builder: (_) =>  AdminNavigation(selectedIndex: selectedIndex,));
      case RouteName.adminIntroPage:
        return MaterialPageRoute(builder: (_) => const AdminIntroPage());

      default:
        return MaterialPageRoute(builder: (_) => const
            Scaffold(
              body: Center(
                child: Text("Error route"),
              ),
            )
        );
    }
  }


}

