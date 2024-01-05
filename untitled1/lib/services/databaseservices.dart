import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/articles.dart';

class DataBaseService {
  DataBaseService();

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("orders");

  Article _articleFromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() != null) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      return Article(
        name: data['name'],
        description: data['description'],
        image: data['image'],
        activity: data['activity'] == 'cooking'
            ? Activity.cooking
            : data['activity'] == 'garden'
                ? Activity.garden
                : data['activity'] == 'hobbies'
                    ? Activity.hobby
                    : data['activity'] == 'house'
                        ? Activity.house
                        : Activity.cooking,
        Uid: data['uid'],
      );
    } else {
      return Article(
        name: 'Unknow',
        description:
            'Donec sed erat ut magna suscipit mattis. Aliquam erat volutpat. ',
        image: 'assets/images/logo.png',
        activity: Activity.cooking,
        Uid: 'Unknow',
      );
    }
  }

  List<Article> _articlesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return _articleFromSnapshot(doc);
    }).toList();
  }

  Stream<List<Article>> get cookingOrders {
    return FirebaseFirestore.instance
        .collection("orders")
        .doc("all")
        .collection("cooking")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Article.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<Article>> get gardenOrders {
    return FirebaseFirestore.instance
        .collection("orders")
        .doc("all")
        .collection("garden")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Article.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<Article>> get houseOrders {
    return FirebaseFirestore.instance
        .collection("orders")
        .doc("all")
        .collection("house")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Article.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<Article>> get hobbyOrders {
    return FirebaseFirestore.instance
        .collection("orders")
        .doc("all")
        .collection("hobby")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Article.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
