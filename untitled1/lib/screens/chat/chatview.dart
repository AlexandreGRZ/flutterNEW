import 'package:dto/chatparams.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class chatView extends StatelessWidget {
  static const routeName = "chatview";
  final ChatParams chatParams;

  const chatView({super.key, required this.chatParams});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1E6C6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFAFC073),
        elevation: 0.0,
        title: Text('Chat with ${chatParams.peer.name ?? 'Unknow'}'),
      ),
      body: Chat(
        chatParams: chatParams,
      ),
    );
  }
}
