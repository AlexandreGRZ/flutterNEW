import 'package:dto/chatparams.dart';
import 'package:dto/message.dart';
import 'package:dto/user.dart';
import 'package:dymatestflutter/material/loading.dart';
import 'package:dymatestflutter/services/userdatabaseservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../chat/chatview.dart';

class messageItem extends StatelessWidget {
  final Message message;

  messageItem({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);
    return StreamBuilder(
      stream: userDatabaseServices(
              message.idTo == currentUser!.uid ? message.idFrom : message.idTo)
          .user,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          AppUserData user = snapshot.data;
          print(user.name!);
          return Card(
            color: Colors.white,
            child: InkWell(
              splashColor: Colors.lightGreen[100],
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => chatView(
                            chatParams: ChatParams(currentUser!.uid, user))))
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CircleAvatar(
                            radius: 35,
                            backgroundImage: user.image != ""
                                ? NetworkImage(user.image!)
                                : const AssetImage(
                                        'assets/images/unknowprofile.png')
                                    as ImageProvider<Object>)),
                    Expanded(
                      flex: 8,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0,
                                  right: 10.0,
                                  left: 5.0,
                                  bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(user.name!),
                                  Text("8m ago"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, left: 5.0, bottom: 10.0),
                              child: Text("fjekbvzihubjorknplm"),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
