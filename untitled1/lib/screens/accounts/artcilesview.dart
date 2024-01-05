import 'package:dto/articles.dart';
import 'package:flutter/material.dart';
import 'ordersitem.dart';

class articlesView extends StatelessWidget {
  List<Article> listArticles;

  articlesView({super.key, required this.listArticles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ordersitem(order: listArticles[index]);
      },
      itemCount: listArticles.length,
    );
  }
}
