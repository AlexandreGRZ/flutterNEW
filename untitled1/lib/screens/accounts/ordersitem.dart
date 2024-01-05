import 'package:dto/articles.dart';
import 'package:flutter/material.dart';

class ordersitem extends StatelessWidget {
  final Article order;

  const ordersitem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: () => {},
        splashColor: Colors.lightGreen[100],
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(order.image!),
                ),
              ),
              Expanded(
                flex: 8,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 10.0, left: 5.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(order.name!),
                            const Text("8m ago"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, left: 5.0, bottom: 10.0),
                        child: Text(order.description!),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
