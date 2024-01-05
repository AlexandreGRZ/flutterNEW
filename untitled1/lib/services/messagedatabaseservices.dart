import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/message.dart';
import 'package:dto/user.dart';

class MessageDatabaseService {
  Stream<List<Message>> getMessage(
      String groupChatId, int limit, AppUser user) {
    return FirebaseFirestore.instance
        .collection('messagesContent')
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map(_messageListFromSnapshot);
  }

  void onSendMessage(String groupChatId, Message message) {
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(message.idTo)
        .collection("user_messages")
        .doc(groupChatId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, {'groupChatId': groupChatId});
    });

    var documentReference2 = FirebaseFirestore.instance
        .collection('messages')
        .doc(message.idFrom)
        .collection("user_messages")
        .doc(groupChatId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference2, {'groupChatId': groupChatId});
    });

    var documentReference3 = FirebaseFirestore.instance
        .collection('messagesContent')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().microsecondsSinceEpoch.toString());
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference3, message.toHashMap());
    });
  }

  List<Message> _messageListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _messageFromSnapshot(doc);
    }).toList();
  }

  Message _messageFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("message not found");
    return Message.fromMap(data);
  }
}
