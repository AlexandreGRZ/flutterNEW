import 'package:dto/articles.dart';
import 'package:dymatestflutter/screens/addordersscreen/oderdetailsview.dart';
import 'package:flutter/material.dart';

class locationElement extends StatelessWidget {
  final Article articles;

  locationElement({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 5,
          child: InkWell(
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => orderDetailsView(
                      a: this.articles,
                    ), // Remplace orderDetailsView() par la page que tu veux afficher
                  ))
            },
            child: SizedBox(
                height: 95,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  NetworkImage(this.articles.image!),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  this.articles.name ?? "Unknow",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey[800]),
                                ),
                                Text(
                                  this.articles.description ??
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla purus sem, eleifend in purus a, semper vehicula ipsum.",
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "11 min ago",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[500],
                              ),
                            ))
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
      const SizedBox(
        height: 5.00,
      ),
    ]);
  }
}
