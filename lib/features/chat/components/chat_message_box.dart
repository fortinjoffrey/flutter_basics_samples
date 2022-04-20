import 'package:flutter/material.dart';
import 'package:swipe_to_reply/features/chat/components/chat_quoted_message_box.dart';
import 'package:swipe_to_reply/features/chat/models/message.dart';

class ChatMessageBox extends StatelessWidget {
  const ChatMessageBox({
    Key? key,
    required this.message,
    required this.fromCurrentUser,
  }) : super(key: key);

  final Message message;
  final bool fromCurrentUser;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: message.quotedMessage != null
            ? ChatMessageBoxWithQuotedMessage(message: message)
            : _ChatMessageBoxContent(message: message),
        decoration: BoxDecoration(
          color: fromCurrentUser ? Colors.green[200] : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class ChatMessageBoxWithQuotedMessage extends StatelessWidget {
  const ChatMessageBoxWithQuotedMessage({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.quotedMessage != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.5),
                border:  const Border(
                  left: BorderSide(color: Colors.grey, width: 8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChatQuotedMessageBox(message: message.quotedMessage!),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: _ChatMessageBoxContent(message: message),
        ),
      ],
    );
  }
}

class _ChatMessageBoxContent extends StatelessWidget {
  const _ChatMessageBoxContent({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final MessageContent content = message.content;
    if (content is MessageContentText) {
      return Text(content.text);
    } else if (content is MessageContentImage) {
      return Image.asset(content.url);
    } else if (content is MessageContentAudio) {
      return Image.asset(content.url);
    }
    return const SizedBox.shrink();
  }
}
