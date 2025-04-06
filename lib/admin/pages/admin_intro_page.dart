import 'package:flutter/material.dart';
import 'package:just_do_it_shop/core/core.dart';


class AdminIntroPage extends StatefulWidget {
  const AdminIntroPage({super.key});

  @override
  State<AdminIntroPage> createState() => _AdminIntroPageState();
}

class _AdminIntroPageState extends State<AdminIntroPage> {
  @override
  Widget build(BuildContext context) {
    AppConfigSize.init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/nike_loo.png", color: Theme.of(context).colorScheme.primary,),
            SizedBox(height: 40,),
            Text(
              "Just Do It",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 23
              ),
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Brand new sneakers and custom kikcs made with premium quality",
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),
            SizedBox(height: 60,),
            Container(
              width: 300,
              height: 65,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      foregroundColor: WidgetStatePropertyAll(Colors.white)
                  ),
                  onPressed: (){
                    Navigator.pushNamed(
                        context,
                        RouteName.adminNavigation,
                        arguments: 0
                    );
                  },
                  child: Text(
                    "Shop now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
