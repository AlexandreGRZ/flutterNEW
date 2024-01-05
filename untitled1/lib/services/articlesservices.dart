import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/articles.dart';
import 'package:firebase_storage/firebase_storage.dart';

class articlesServices {
  final String Uid;

  articlesServices({required this.Uid});

  final CollectionReference oprderCollection =
      FirebaseFirestore.instance.collection("orders");
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("articles");

  Future<void> saveArticle(Article a, File Image) async {
    String imagename =
        a.name! + Uid + DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference =
        FirebaseStorage.instance.ref().child("images/$imagename");

    UploadTask uploadTask = storageReference.putFile(Image);
    TaskSnapshot storageSnapshot = await uploadTask;

    String imageUrl = await storageSnapshot.ref.getDownloadURL();

    await userCollection.doc(Uid).collection("user_articles").add({
      "name": a.name,
      'image': imageUrl,
      'description': a.description,
      'activity': a.parseToString(a.activity),
      'uid': a.Uid,
    });

    switch (a.activity) {
      case Activity.cooking:
        await oprderCollection.doc('all').collection("cooking").doc().set({
          "name": a.name,
          'image': imageUrl,
          'description': a.description,
          'activity': a.parseToString(a.activity),
          'uid': a.Uid,
        });
        break;
      case Activity.garden:
        await oprderCollection.doc('all').collection("garden").doc().set({
          "name": a.name,
          'image': imageUrl,
          'description': a.description,
          'activity': a.parseToString(a.activity),
          'uid': a.Uid,
        });
        break;
      case Activity.house:
        await oprderCollection.doc('all').collection("house").doc().set({
          "name": a.name,
          'image': imageUrl,
          'description': a.description,
          'activity': a.parseToString(a.activity),
          'uid': a.Uid,
        });
        break;
      case Activity.hobby:
        await oprderCollection.doc('all').collection("hobby").doc().set({
          "name": a.name,
          'image': imageUrl,
          'description': a.description,
          'activity': a.parseToString(a.activity),
          'uid': a.Uid,
        });
        break;
      default:
        break;
    }
  }
}
