import 'package:dto/articles.dart';
import 'package:dymatestflutter/material/loading.dart';
import 'package:dymatestflutter/screens/displayscreens/bottomnavigationbar.dart';
import 'package:dymatestflutter/screens/displayscreens/locationelement.dart';
import 'package:dymatestflutter/services/databaseservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class hobbieview extends StatefulWidget {
  static const routeName = "hobbieview";

  const hobbieview({super.key});

  @override
  State<hobbieview> createState() => _hobbieviewState();
}

class _hobbieviewState extends State<hobbieview> {
  int _selecteditems = 4;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataBaseService().hobbyOrders,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<Article> hobbieorders = snapshot.data ?? List.from([]);
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
                  "Hobbie",
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
                    return locationElement(articles: hobbieorders[index]);
                  },
                  itemCount: hobbieorders.length,
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
