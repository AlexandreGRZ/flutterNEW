import 'package:dto/message.dart';
import 'package:dymatestflutter/screens/accounts/messageitem.dart';
import 'package:dymatestflutter/services/databaseservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class messageView extends StatelessWidget {
  List<List<Message>> listMessages;
  messageView({super.key, required this.listMessages});

  @override
  Widget build(BuildContext context) {
    print(listMessages.length);
    return ListView.builder(
      itemBuilder: (context, index) {
        return messageItem(
          message: listMessages[index].length >= 2
              ? listMessages[index][1]
              : listMessages[0][0],
        );
      },
      itemCount: listMessages.length,
    );
    ;
  }
}
