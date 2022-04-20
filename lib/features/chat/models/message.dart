
abstract class MessageContent {}

class MessageContentText implements MessageContent {
  final String text;

  MessageContentText({required this.text});
}

class MessageContentImage implements MessageContent {
  final String url;

  MessageContentImage({required this.url});
}

class MessageContentAudio implements MessageContent {
  final String url;

  MessageContentAudio({required this.url});
}

class Message {
  final int senderId;
  final String authorName;
  final MessageContent content;
  final Message? quotedMessage;

  const Message({
    required this.content,
    required this.senderId,
    required this.authorName,
    this.quotedMessage,
  });

  bool isFromCurrentUser(int userId) {
    return userId == senderId;
  }
}
