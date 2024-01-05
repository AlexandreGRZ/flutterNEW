library dto;

import 'articles.dart';
import 'message.dart';

class AppUser {
  final String? uid;

  AppUser({required this.uid});
}

class AppUserData {
  final String? uid;
  final String? name;
  final String? image;
  final List<List<Message>>? userMessage;
  final List<Article>? userOrder;

  AppUserData({
    this.uid,
    this.name,
    this.image,
    this.userMessage,
    this.userOrder,
  });

  @override
  String toString() {
    return 'AppUserData{uid: $uid, name: $name}';
  }
}
