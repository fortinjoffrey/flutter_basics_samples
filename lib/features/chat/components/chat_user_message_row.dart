import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to_reply/features/chat/components/chat_message_box.dart';
import 'package:swipe_to_reply/features/chat/models/dummy_data.dart';
import 'package:swipe_to_reply/features/chat/models/message.dart';
import 'package:swipe_to_reply/features/chat/models/message_box_border_radius_data.dart';

class ChatUserMessageRow extends StatelessWidget {
  const ChatUserMessageRow({Key? key, required this.message}) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    final isMessageFromCurrentUser = message.isFromCurrentUser(currentUser.uid);
    final BorderRadiusFlags borderRadiusData = context.read<BorderRadiusFlags>();

    return Row(
      mainAxisAlignment: isMessageFromCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ChatMessageBox(
          message: message,
          fromCurrentUser: isMessageFromCurrentUser,
          borderRadiusFlags: borderRadiusData,
        ),
      ],
    );
  }
}
