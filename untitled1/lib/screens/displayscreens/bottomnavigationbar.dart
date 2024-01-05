import 'package:dymatestflutter/screens/accounts/mainaccountview.dart';
import 'package:dymatestflutter/screens/displayscreens/cookingview.dart';
import 'package:dymatestflutter/screens/displayscreens/gardenview.dart';
import 'package:dymatestflutter/screens/displayscreens/hobbieview.dart';
import 'package:dymatestflutter/screens/displayscreens/houseview.dart';
import 'package:dymatestflutter/screens/transitonpage/leftslidetransitionpage.dart';
import 'package:dymatestflutter/screens/transitonpage/notransitionpage.dart';
import 'package:dymatestflutter/screens/transitonpage/rightslidetransitionpage.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  final int selecteditems;

  bottomNavigationBar({super.key, required this.selecteditems});

  @override
  State<bottomNavigationBar> createState() =>
      _bottomNavigationBarState(selecteditems);
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int selecteditems;
  _bottomNavigationBarState(this.selecteditems);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selecteditems,
      onTap: (index) {
        if (index != selecteditems) {
          if (index == 0) {
            Navigator.of(context)
                .push(leftSlideTransitionPage(page: mainAccountView()));
          }
          if (index == 1) {
            if (selecteditems == 0) {
              Navigator.of(context)
                  .push(rightSlideTransitionPage(page: cookingview()));
            } else {
              Navigator.push(
                context,
                noTransitionPage(builder: (context) => cookingview()),
              );
            }
          } else if (index == 2) {
            Navigator.push(
              context,
              noTransitionPage(builder: (context) => gardenview()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              noTransitionPage(builder: (context) => houseview()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              noTransitionPage(builder: (context) => hobbieview()),
            );
          }
          setState(() {
            selecteditems = index;
          });
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.coffee_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.garage), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.house), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.sports_basketball), label: ''),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.green[400],
      unselectedItemColor: Colors.grey[500],
      selectedFontSize: 0.0,
      unselectedFontSize: 0.0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.lightGreen[200],
      iconSize: 35.0,
    );
  }
}
