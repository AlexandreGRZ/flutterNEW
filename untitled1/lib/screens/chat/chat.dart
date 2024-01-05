import 'dart:io';

import 'package:dto/chatparams.dart';
import 'package:dto/message.dart';
import 'package:dto/user.dart';
import 'package:dymatestflutter/screens/chat/contentmessageitem.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../material/loading.dart';
import '../../services/messagedatabaseservices.dart';

class Chat extends StatefulWidget {
  static const routeName = "chat";
  final ChatParams chatParams;

  const Chat({super.key, required this.chatParams});

  @override
  State<Chat> createState() => _ChatState(chatParams);
}

class _ChatState extends State<Chat> {
  final ChatParams chatParams;

  final MessageDatabaseService messageService = MessageDatabaseService();
  _ChatState(this.chatParams);

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  int _nbElement = 20;
  static const int PAGINATION_INCREMENT = 20;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _nbElement += PAGINATION_INCREMENT;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [buildListMessage(), buildInput()],
        ),
        isLoading ? const Loading() : Container()
      ],
    );
  }

  Widget buildListMessage() {
    final currentUser = Provider.of<AppUser?>(context);
    return Flexible(
      child: StreamBuilder<List<Message>>(
        stream: messageService.getMessage(
            chatParams.getChatGroupid(), _nbElement, currentUser!),
        builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
          if (snapshot.hasData) {
            List<Message> listMessage = snapshot.data ?? List.from([]);
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (context, index) => contentMessageItem(
                  message: listMessage[index],
                  userId: chatParams.userUid ?? '',
                  isLastMessage: isLastMessage(index, listMessage)),
              itemCount: listMessage.length,
              reverse: true,
              controller: listScrollController,
            );
          } else {
            return const Center(child: Loading());
          }
        },
      ),
    );
  }

  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: [
          Material(
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: const Icon(Icons.image),
                onPressed: () {},
                color: const Color(0xFFAFC073),
              ),
            ),
          ),
          Flexible(
              child: TextField(
            onSubmitted: (value) {
              onSendMessage(textEditingController.text, 0);
            },
            style: const TextStyle(color: Color(0xFFAFC073), fontSize: 15.0),
            controller: textEditingController,
            decoration: const InputDecoration.collapsed(
              hintText: "Your message...",
              hintStyle: TextStyle(color: Colors.black87),
            ),
          )),
          Material(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: const Color(0xFFAFC073),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future getImage() async {
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     uploadFile(image);
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: "Error selecting image. Try again !");
  //   }
  // }

  void onSendMessage(String content, int type) {
    if (content.trim() != '') {
      messageService.onSendMessage(
          chatParams.getChatGroupid(),
          Message(chatParams.userUid ?? '', chatParams.peer.uid ?? '',
              DateTime.now().microsecondsSinceEpoch.toString(), content, type));
      listScrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      textEditingController.clear();
    } else {
      /*Fluttertoast.showToast(
        msg: 'Nothing to send',
        backgroundColor: Colors.black87,
        textColor: Colors.red,
      );*/
    }
  }

  // void uploadFile(XFile image) async {
  //   print("Uploading image. Path: ${image.path}");
  //   String fileName = "${DateTime.now().microsecondsSinceEpoch}.jpg";
  //   try {
  //     Reference reference = FirebaseStorage.instance.ref(fileName);
  //     final metadata = SettableMetadata(
  //         contentType: 'image/jpg',
  //         customMetadata: {'picked-file-path': image.path});
  //
  //     TaskSnapshot snapshot;
  //     if (kIsWeb) {
  //       snapshot = await reference.putData(await image.readAsBytes(), metadata);
  //     } else {
  //       snapshot = await reference.putFile(File(image.path), metadata);
  //     }
  //
  //     String imageUrl = await snapshot.ref.getDownloadURL();
  //     setState(() {
  //       isLoading = false;
  //       onSendMessage(imageUrl, 1);
  //     });
  //   } on Exception {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     Fluttertoast.showToast(msg: "Error! Try again !");
  //   }
  // }

  bool isLastMessage(int index, List<Message> listMessage) {
    if (index == 0) return true;
    if (listMessage[index].idFrom != listMessage[index - 1].idFrom) return true;
    return false;
  }
}
