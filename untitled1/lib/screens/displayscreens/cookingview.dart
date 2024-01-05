import 'dart:io';

import 'package:dto/articles.dart';
import 'package:dymatestflutter/material/loading.dart';
import 'package:dymatestflutter/screens/displayscreens/bottomnavigationbar.dart';
import 'package:dymatestflutter/screens/displayscreens/locationelement.dart';
import 'package:dymatestflutter/services/databaseservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class cookingview extends StatefulWidget {
  static const routeName = "cookingview";

  const cookingview({super.key});

  @override
  State<cookingview> createState() => _cookingviewState();
}

class _cookingviewState extends State<cookingview> {
  int _selecteditems = 1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Article>>(
      stream: DataBaseService().cookingOrders,
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.hasData) {
          List<Article> cookingOrders = snapshot.data ?? List.from([]);
          return Scaffold(
            bottomNavigationBar: bottomNavigationBar(
              selecteditems: _selecteditems,
            ),
            body: Container(
              color: Colors.lightGreen[100],
              child: Column(children: [
                const SizedBox(
                  height: 75.00,
                ),
                Text(
                  "Cooking",
                  style: TextStyle(fontSize: 35, color: Colors.green[400]),
                ),
                const SizedBox(
                  height: 25.00,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: TextFormField(
                            autocorrect: false,
                            decoration: const InputDecoration(
                              hintText: "Search",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10.00,
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return locationElement(articles: cookingOrders[index]);
                  },
                  itemCount: cookingOrders.length,
                ))
              ]),
            ),
          );
        } else {
          return Center(child: Loading());
        }
      },
    );
  }
}
