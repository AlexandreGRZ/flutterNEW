library dto;

import 'package:dto/user.dart';

class ChatParams {
  final String? userUid;
  final AppUserData peer;

  ChatParams(this.userUid, this.peer);

  String getChatGroupid() {
    if (userUid.hashCode <= peer.uid.hashCode) {
      return '$userUid-${peer.uid}';
    } else {
      return '${peer.uid}-$userUid';
    }
  }
}
