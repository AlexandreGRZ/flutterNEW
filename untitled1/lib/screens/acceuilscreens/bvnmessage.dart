import 'package:flutter/material.dart';

class bvnMessage extends StatelessWidget {
  const bvnMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 50.00,
          ),
          Image.asset(
            "assets/images/logo.png",
            height: 150.00,
          ),
          const SizedBox(
            height: 50.0,
          ),
          const Center(
            child: Text.rich(
              TextSpan(
                  text: "Bienvenue !\n",
                  children: <TextSpan>[
                    TextSpan(
                      text: "Rejoint nous on a besoin de toi !",
                      style: TextStyle(fontSize: 15.0),
                    )
                  ],
                  style: TextStyle(fontSize: 40.00)),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
