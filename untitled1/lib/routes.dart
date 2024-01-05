import 'package:dymatestflutter/screens/acceuilscreens/home.dart';
import 'package:dymatestflutter/screens/accounts/mainaccountview.dart';
import 'package:dymatestflutter/screens/addordersscreen/addorderview.dart';
import 'package:dymatestflutter/screens/authentificationscreens/login/loginview.dart';
import 'package:dymatestflutter/screens/authentificationscreens/signin/signinview.dart';
import 'package:dymatestflutter/screens/displayscreens/cookingview.dart';
import 'package:dymatestflutter/screens/displayscreens/gardenview.dart';
import 'package:dymatestflutter/screens/displayscreens/hobbieview.dart';
import 'package:dymatestflutter/screens/displayscreens/houseview.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  Home.routeName: (context) => const Home(),
  loginView.routeName: (context) => const loginView(),
  signinView.routeName: (context) => const signinView(),
  cookingview.routeName: (context) => const cookingview(),
  houseview.routeName: (context) => const houseview(),
  gardenview.routeName: (context) => const gardenview(),
  hobbieview.routeName: (context) => const hobbieview(),
  mainAccountView.routeName: (context) => const mainAccountView(),
  addorderview.routeName: (context) => const addorderview(),
};
