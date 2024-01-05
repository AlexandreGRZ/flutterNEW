library dto;

class Message {
  final String idFrom;
  final String idTo;
  final String timestamp;
  final String content;

  //type:0 = Text, 1 = image
  final int type;

  Message(this.idFrom, this.idTo, this.timestamp, this.content, this.type);

  Map<String, dynamic> toHashMap() {
    return {
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
      'type': type
    };
  }

  static Message fromFirestore(Map<String, dynamic> data) {
    return Message(data["idFrom"], data["idTo"], data["timestamp"],
        data["content"], data["type"]);
  }

  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(data['idFrom'], data['idTo'], data['timestamp'],
        data['content'], data['type']);
  }

  @override
  String toString() {
    return 'Message{idFrom: $idFrom, idTo: $idTo, timestamp: $timestamp, content: $content, type: $type}';
  }
}
