import 'package:dto/user.dart';
import 'package:dymatestflutter/material/gradientbtn.dart';
import 'package:dymatestflutter/screens/authentificationscreens/login/loginview.dart';
import 'package:dymatestflutter/screens/authentificationscreens/signin/signinview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bvnmessage.dart';

class Home extends StatelessWidget {
  static const routeName = "/";
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: bvnMessage()),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: Colors.lightGreen[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 100.0),
                  gradientBtn(
                    onPressed: () =>
                        {Navigator.pushNamed(context, signinView.routeName)},
                    gradient: const LinearGradient(
                      colors: [Colors.lightGreen, Colors.green],
                    ),
                    borderRadius: BorderRadius.circular(100.0),
                    height: 60.0,
                    width: 200.0,
                    child: const Text(
                      "Inscription",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  gradientBtn(
                      onPressed: () =>
                          {Navigator.pushNamed(context, loginView.routeName)},
                      borderRadius: BorderRadius.circular(100.0),
                      height: 60.0,
                      width: 200.0,
                      gradient: const LinearGradient(
                        colors: [Colors.green, Colors.lightGreen],
                      ),
                      child: const Text(
                        "Connexion",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle), label: "Accounts"),
      //     BottomNavigationBarItem(icon: Icon(Icons.garage), label: "Garden"),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   child: const Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
