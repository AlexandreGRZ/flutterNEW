import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dto/user.dart';
import 'package:dymatestflutter/services/databaseservices.dart';
import 'package:dymatestflutter/services/userdatabaseservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

class authentificationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFireBaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        AppUserData userData = AppUserData(
            uid: user.uid,
            name: name,
            image: "",
            userMessage: [[]],
            userOrder: []);
        await userDatabaseServices(user.uid).saveUser(userData);
      }

      return _userFromFireBaseUser(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
