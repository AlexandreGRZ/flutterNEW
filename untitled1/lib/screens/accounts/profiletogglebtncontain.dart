import 'package:dto/user.dart';
import 'package:dymatestflutter/screens/accounts/artcilesview.dart';
import 'package:dymatestflutter/screens/accounts/messagesview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../material/loading.dart';
import '../../material/togglebtnaccount.dart';
import '../../services/userdatabaseservices.dart';
import 'messageitem.dart';
import 'ordersitem.dart';

class profileToggleBtnContain extends StatefulWidget {
  const profileToggleBtnContain({super.key});

  static bool isbuild = false;
  @override
  State<profileToggleBtnContain> createState() =>
      _profileToggleBtnContainState();

  static _profileToggleBtnContainState? state;
}

class _profileToggleBtnContainState extends State<profileToggleBtnContain> {
  bool togglebtnbool = true;
  static GlobalKey<_profileToggleBtnContainState> _currentStateKey =
      GlobalKey<_profileToggleBtnContainState>();

  @override
  void initState() {
    super.initState();
    profileToggleBtnContain.state = this;
  }

  void changetogglebtn() {
    setState(() {
      togglebtnbool = !togglebtnbool;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);

    return StreamBuilder(
      stream: userDatabaseServices(user.uid).user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Les données sont en cours de chargement
          return Loading();
        } else if (snapshot.hasError) {
          // Une erreur s'est produite
          return Text('Erreur: ${snapshot.error}');
        } else {
          AppUserData userData = snapshot.data!;
          return Column(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  right: 10.0,
                  left: 5.0,
                ),
                child: togglebtnbool
                    ? articlesView(listArticles: userData.userOrder!)
                    : messageView(listMessages: userData.userMessage!),
              ),
            ),
          ]);
        }
      },
    );
  }
}
