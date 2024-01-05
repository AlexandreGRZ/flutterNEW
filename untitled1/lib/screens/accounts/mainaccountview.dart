import 'dart:io';

import 'package:dto/user.dart';
import 'package:dymatestflutter/material/gradientbtn.dart';
import 'package:dymatestflutter/material/loading.dart';
import 'package:dymatestflutter/material/togglebtnaccount.dart';
import 'package:dymatestflutter/screens/acceuilscreens/bvnmessage.dart';
import 'package:dymatestflutter/screens/accounts/artcilesview.dart';
import 'package:dymatestflutter/screens/accounts/messageitem.dart';
import 'package:dymatestflutter/screens/accounts/messagesview.dart';
import 'package:dymatestflutter/screens/accounts/ordersitem.dart';
import 'package:dymatestflutter/screens/accounts/profiletogglebtncontain.dart';
import 'package:dymatestflutter/screens/addordersscreen/addorderview.dart';
import 'package:dymatestflutter/screens/displayscreens/bottomnavigationbar.dart';
import 'package:dymatestflutter/services/authentificationservices.dart';
import 'package:dymatestflutter/services/userdatabaseservices.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../acceuilscreens/home.dart';

class mainAccountView extends StatefulWidget {
  static const routeName = "mainaccountview";
  const mainAccountView({super.key});

  @override
  State<mainAccountView> createState() => _mainAccountViewState();
}

class _mainAccountViewState extends State<mainAccountView> {
  int selecteditems = 0;
  File? _image;
  final GlobalKey<_mainAccountViewState> _parentKey =
      GlobalKey<_mainAccountViewState>();
  Future<File?> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      return imageFile;
    }
    return null;
  }

  void reloadParent() {
    setState(() {});
  }

  void _voidCallback(AppUserData userData) {
    profileToggleBtnContain.state?.changetogglebtn();
  }

  @override
  Widget build(BuildContext context) {
    final currentuser = Provider.of<AppUser?>(context);
    return StreamBuilder(
        stream: userDatabaseServices(currentuser!.uid).user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Les données sont en cours de chargement
            return Loading();
          } else if (snapshot.hasError) {
            // Une erreur s'est produite
            return Text('Erreur: ${snapshot.error}');
          } else {
            AppUserData userData = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: const Text(
                  "Profile",
                  style: TextStyle(fontSize: 25.0),
                ),
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.settings)),
                  IconButton(
                      onPressed: () {
                        authentificationServices().signout();
                        Navigator.pushNamed(context, Home.routeName);
                      },
                      icon: const Icon(Icons.logout)),
                ],
                backgroundColor: Colors.lightGreen[200],
                elevation: 0,
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(color: Colors.lightGreen[200])),
                      Expanded(flex: 8, child: Container())
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Column(children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 3.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 3.0,
                                  blurRadius: 5.0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () async {
                                File? newImage = await _pickImage();

                                if (newImage != null) {
                                  setState(() {
                                    _image = newImage;
                                    userDatabaseServices(currentuser.uid)
                                        .updateUserImage(_image!);

                                    _parentKey.currentState?.reloadParent();
                                  });
                                }
                              },
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: userData.image != ""
                                    ? NetworkImage(userData.image!)
                                    : const AssetImage(
                                            'assets/images/unknowprofile.png')
                                        as ImageProvider<Object>,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            userData.name!,
                            style: const TextStyle(fontSize: 30),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ]),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 90,
                            child: toggleBtnAccount(
                              voidCallback: () => _voidCallback(userData),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(),
                          ),
                        ],
                      ),
                      const Expanded(
                        child: profileToggleBtnContain(),
                      ),
                    ],
                  ),
                ],
              ),
              floatingActionButton: Container(
                width: 65,
                height: 65,
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.lightGreen[300],
                  child: Icon(Icons.add),
                  heroTag: 'jfoen',
                  onPressed: () {
                    Navigator.pushNamed(context, addorderview.routeName);
                  },
                  mini: false,
                ),
              ),
              bottomNavigationBar: bottomNavigationBar(
                selecteditems: selecteditems,
              ),
            );
          }
        });
  }
}
