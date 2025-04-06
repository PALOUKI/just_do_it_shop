import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/core.dart';
import 'package:just_do_it_shop/providers/favorite_provider.dart';
import 'package:just_do_it_shop/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/cart_provider.dart';
import 'services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppConfigSize.init(context);
    return Consumer<ThemeProvider>(
      builder:
          (context, themeProvider, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Provider.of<ThemeProvider>(context).themeData,
            initialRoute: RouteName.adminIntroPage,
            onGenerateRoute: Routes.onGenerateRoute,
          ),
    );
  }
}
