import 'package:dto/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../material/loading.dart';

class contentMessageItem extends StatelessWidget {
  final Message message;
  final String userId;
  final bool isLastMessage;

  const contentMessageItem(
      {Key? key,
      required this.message,
      required this.userId,
      required this.isLastMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: userId == message.idFrom
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: userId == message.idFrom
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [message.type == 0 ? messageContainer() : imageContainer()],
        ),
        isLastMessage
            ? Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                child: Text(
                  DateFormat('dd MMM kk:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(message.timestamp))),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic),
                ),
              )
            : Container()
      ],
    );
  }

  Widget messageContainer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      width: 200.0,
      decoration: BoxDecoration(
          color: userId == message.idFrom ? Colors.grey : Colors.blueGrey,
          borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
      child: Text(
        message.content,
        style: TextStyle(
            color: userId == message.idFrom ? Colors.black : Colors.white),
      ),
    );
  }

  Widget imageContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          message.content,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              decoration: BoxDecoration(
                color: userId == message.idFrom ? Colors.grey : Colors.blueGrey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              width: 200.0,
              height: 200.0,
              child: const Center(
                child: Loading(),
              ),
            );
          },
          errorBuilder: (context, object, stackTrace) {
            return Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              child: Image.asset(
                'images/img_not_available.jpeg',
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            );
          },
          width: 200.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
