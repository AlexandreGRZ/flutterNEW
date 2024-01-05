import 'package:dto/articles.dart';
import 'package:dto/chatparams.dart';
import 'package:dto/user.dart';
import 'package:dymatestflutter/material/gradientbtn.dart';
import 'package:dymatestflutter/material/loading.dart';
import 'package:dymatestflutter/screens/chat/chatview.dart';
import 'package:dymatestflutter/services/userdatabaseservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class orderDetailsView extends StatelessWidget {
  Article a;

  orderDetailsView({super.key, required this.a});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nom de l'objet"),
        backgroundColor: Colors.lightGreen[300],
      ),
      body: Container(
        color: Colors.lightGreen[100],
        child: Column(children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(image: NetworkImage(a.image!)),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.name!,
                      style: const TextStyle(fontSize: 25),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Prix : ",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Expire le ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Description"),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 2,
                    color: Colors.green[700],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(a.description!),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: StreamBuilder(
              stream: userDatabaseServices(a.Uid).user,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  AppUserData user = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: user.image != ""
                                ? NetworkImage(user.image!)
                                : const AssetImage(
                                        'assets/images/unknowprofile.png')
                                    as ImageProvider<Object>,
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            user.name!,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            child: gradientBtn(
                              height: 50.0,
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => chatView(
                                            chatParams: ChatParams(
                                                currentUser!.uid, user))))
                              },
                              gradient: const LinearGradient(
                                colors: [Colors.green, Colors.lightGreen],
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                              child: const Text("Contacter"),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            child: gradientBtn(
                              height: 50.0,
                              onPressed: () => {},
                              gradient: const LinearGradient(
                                colors: [Colors.green, Colors.lightGreen],
                              ),
                              borderRadius: BorderRadius.circular(100.0),
                              child: const Text("Reserver"),
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Loading();
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
