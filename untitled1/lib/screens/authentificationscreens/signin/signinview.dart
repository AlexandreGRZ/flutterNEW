import 'package:dymatestflutter/screens/authentificationscreens/login/loginview.dart';
import 'package:dymatestflutter/screens/displayscreens/cookingview.dart';
import 'package:flutter/material.dart';

import '../../../material/gradientbtn.dart';
import '../../../services/authentificationservices.dart';
import '../../acceuilscreens/home.dart';

class signinView extends StatefulWidget {
  static const routeName = "/signinview";
  const signinView({super.key});

  @override
  State<signinView> createState() => _signinViewState();
}

class _signinViewState extends State<signinView> {
  bool showPassWorld = false;
  final authentificationServices _auth = authentificationServices();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightGreen[100],
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 125.00,
            ),
            const Text(
              "Inscription",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 50.00,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        child: TextFormField(
                          autocorrect: false,
                          decoration: const InputDecoration(
                              hintText: "Email", prefixIcon: Icon(Icons.email)),
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter an email";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 25.00,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        child: TextFormField(
                          autocorrect: false,
                          decoration: const InputDecoration(
                              hintText: "Nom", prefixIcon: Icon(Icons.person)),
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Entrez un nom";
                            }
                            return null;
                          },
                        )),
                    const SizedBox(
                      height: 25.00,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            TextFormField(
                              obscureText: !showPassWorld,
                              autocorrect: false,
                              decoration: const InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.password)),
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.length < 6) {
                                  return "Enter an password with at least 6 character";
                                }
                                return null;
                              },
                            ),
                            IconButton(
                              icon: Icon(showPassWorld
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  showPassWorld = !showPassWorld;
                                });
                              },
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 25.00,
                    ),
                  ],
                )),
            const SizedBox(
              height: 25.00,
            ),
            Text(
              error,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 15.0,
              ),
            ),
            gradientBtn(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var password = passwordController.value.text;
                    var email = emailController.value.text;
                    var name = nameController.value.text;

                    dynamic result = await _auth.registerWithEmailAndPassword(
                        name, email, password);
                    if (result == null) {
                      setState(() {
                        error = "Please supply a valid email";
                      });
                    } else {
                      Navigator.pushNamed(context, cookingview.routeName);
                    }
                  }
                },
                borderRadius: BorderRadius.circular(100.0),
                height: 60.0,
                width: 200.0,
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.lightGreen],
                ),
                child: const Text(
                  "Inscription",
                  style: TextStyle(fontSize: 20),
                )),
            TextButton(
                onPressed: () =>
                    {Navigator.pushNamed(context, loginView.routeName)},
                child: Text(
                  "Vous avez déja un compte ?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.green[600]),
                ))
          ],
        ),
      ),
    );
  }
}
