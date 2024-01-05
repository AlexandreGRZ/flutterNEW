import 'package:dto/articles.dart';
import 'package:dto/user.dart';
import 'package:dymatestflutter/services/authentificationservices.dart';
import 'package:dymatestflutter/services/databaseservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class providerSettings extends StatelessWidget {
  final child;
  const providerSettings({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser?>.value(
            value: authentificationServices().user, initialData: null),
        StreamProvider<List<Article>>.value(
          value: DataBaseService().cookingOrders,
          initialData: [],
          key: const Key("cookingProvider"),
        ),
        StreamProvider<List<Article>>.value(
            value: DataBaseService().gardenOrders,
            initialData: [],
            key: const Key("gardenProvider")),
        StreamProvider<List<Article>>.value(
            value: DataBaseService().hobbyOrders,
            initialData: [],
            key: const Key("hobbyProvider")),
        StreamProvider<List<Article>>.value(
            value: DataBaseService().houseOrders,
            initialData: [],
            key: const Key("houseProvider")),
      ],
      child: child,
    );
  }
}
