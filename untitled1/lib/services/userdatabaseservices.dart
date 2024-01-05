import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/articles.dart';
import 'package:dto/message.dart';
import 'package:dto/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class userDatabaseServices {
  final String? uid;

  userDatabaseServices(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference articlesCollection =
      FirebaseFirestore.instance.collection("articles");

  final CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection("messages");

  Future<void> saveUser(AppUserData userData) async {
    await userCollection.doc(uid).set({
      'name': userData.name,
      'image': userData.image,
    });
  }

  Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }

  Future<AppUserData> _userFromSnapshot(DocumentSnapshot snapshot) async {
    if (snapshot.data() != null) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      AppUserData app = AppUserData(
        uid: snapshot.id,
        name: data['name'],
        image: data['image'],
        userOrder: await _convertToArticlesList(),
        userMessage: await _convertToMessagesList(),
      );
      return app;
    } else {
      List<Article>? ordernull = [];
      List<List<Message>>? messagenull = [];
      return AppUserData(
        uid: "",
        name: "Nom par défaut",
        image: "assets/images/unknowprofile.png",
        userOrder: ordernull,
        userMessage: messagenull,
      );
    }
  }

  Future<List<Article>> _convertToArticlesList() async {
    QuerySnapshot articlesSnapshot = await FirebaseFirestore.instance
        .collection('articles')
        .doc(uid)
        .collection('user_articles')
        .get();

    List<Article> articlesList = articlesSnapshot.docs.map((doc) {
      return Article.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    return articlesList;
  }

  Future<List<List<Message>>> _convertToMessagesList() async {
    List<List<Message>> ListToReturn = [];

    try {
      QuerySnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore
          .instance
          .collection('messages')
          .doc(uid)
          .collection("user_messages")
          .get();

      if (userSnapshot.size > 0) {
        for (DocumentSnapshot<Map<String, dynamic>> document
            in userSnapshot.docs) {
          Map<String, dynamic> data = document.data()!;
          String groupChatId = data['groupChatId'];

          QuerySnapshot<Map<String, dynamic>> messageContentSnapshot =
              await FirebaseFirestore.instance
                  .collection('messagesContent')
                  .doc(groupChatId)
                  .collection(groupChatId)
                  .get();

          if (messageContentSnapshot.size > 0) {
            // Parcourir les documents inclus dans le snapshot
            List<Message> messagesList =
                messageContentSnapshot.docs.map((messageContentDocument) {
              // Récupérer les données du document messageContent
              Map<String, dynamic> messageContentData =
                  messageContentDocument.data()!;
              return Message.fromFirestore(messageContentData);
            }).toList();

            ListToReturn.add(messagesList);

            //print("Messages pour le groupe $groupChatId: $messagesList");
          } else {
            print(
                "Aucun document trouvé dans messageContent pour le groupe $groupChatId");
          }
        }
      } else {
        print("Aucun document trouvé pour l'utilisateur $uid");
      }
    } catch (e) {
      print("Erreur lors de la récupération des GroupIds : $e");
    }
    return ListToReturn;
  }

  Future<List<AppUserData>> _userListFromSnapshot(
      QuerySnapshot snapshot) async {
    List<Future<AppUserData>> userFutures = snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();

    try {
      List<AppUserData> userList = await Future.wait(userFutures);
      return userList;
    } catch (error) {
      print(
          "Erreur lors de la récupération de la liste d'utilisateurs : $error");
      return [];
    }
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().asyncMap(_userFromSnapshot);
  }

  Stream<List<AppUserData>> get users {
    return userCollection.snapshots().asyncMap((querySnapshot) {
      return _userListFromSnapshot(querySnapshot);
    });
  }

  Future<String> _uploadImage(File image) async {
    String imagename = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference =
        FirebaseStorage.instance.ref().child("profiles/$imagename");

    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot storageSnapshot = await uploadTask;

    String imageUrl = await storageSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

  Future<void> updateUserImage(File newImage) async {
    try {
      String newImageUrl = await _uploadImage(newImage);

      if (newImageUrl.isNotEmpty) {
        await userCollection.doc(uid).update({'image': newImageUrl});
      }
    } catch (e) {
      print("Erreur lors de la mise à jour de l'image de l'utilisateur : $e");
      // Vous pouvez gérer l'erreur selon vos besoins
    }
  }
}
