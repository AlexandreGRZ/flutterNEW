import 'package:dto/user.dart';
import 'package:dymatestflutter/screens/acceuilscreens/home.dart';
import 'package:dymatestflutter/screens/displayscreens/cookingview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    if (user == null) {
      return Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const Home(),
          );
        },
      );
    } else {
      return Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const cookingview(),
          );
        },
      );
    }
  }
}
