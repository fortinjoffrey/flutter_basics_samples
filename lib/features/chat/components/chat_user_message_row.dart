import 'package:flutter/material.dart';
import 'package:swipe_to_reply/features/chat/components/chat_message_box.dart';
import 'package:swipe_to_reply/features/chat/models/dummy_data.dart';
import 'package:swipe_to_reply/features/chat/models/message.dart';

class ChatUserMessageRow extends StatelessWidget {
  const ChatUserMessageRow({Key? key, required this.message}) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    final isMessageFromCurrentUser = message.isFromCurrentUser(currentUser.uid);

    return Row(
      mainAxisAlignment: isMessageFromCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
          ChatMessageBox(message: message, fromCurrentUser: isMessageFromCurrentUser),
      ],
    );
  }
}