import 'package:dto/articles.dart';
import 'package:dymatestflutter/material/loading.dart';
import 'package:dymatestflutter/screens/displayscreens/bottomnavigationbar.dart';
import 'package:dymatestflutter/screens/displayscreens/locationelement.dart';
import 'package:dymatestflutter/services/databaseservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class houseview extends StatefulWidget {
  static const routeName = "houseview";

  const houseview({super.key});

  @override
  State<houseview> createState() => _houseviewState();
}

class _houseviewState extends State<houseview> {
  int _selecteditems = 3;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataBaseService().houseOrders,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<Article> houseorders = snapshot.data ?? List.from([]);
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
                  "House",
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
                    return locationElement(articles: houseorders[index]);
                  },
                  itemCount: houseorders.length,
                ))
              ]),
            ),
          );
        } else {
          return const Center(
            child: Loading(),
          );
        }
      },
    );
  }
}
