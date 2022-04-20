import 'package:flutter/material.dart';
import 'package:swipe_to_reply/features/chat/models/message.dart';

class ChatQuotedMessageBox extends StatelessWidget {
  const ChatQuotedMessageBox({Key? key, required this.message, this.onQuotedMessagePreviewClosePressed}) : super(key: key);

  final Message message;
  final VoidCallback? onQuotedMessagePreviewClosePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(message.authorName),
          _ChatQuotedMessageContent(message: message),
      ],
    );
  }
}

class _ChatQuotedMessageContent extends StatelessWidget {
  const _ChatQuotedMessageContent({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final MessageContent content = message.content;
    if (content is MessageContentText) {
      return Text(content.text);
    } else if (content is MessageContentImage) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.photo),
          SizedBox(
            child: Image.asset(content.url),
            width: 50,
          ),
        ],
      );
    } else if (content is MessageContentAudio) {
      return const Icon(Icons.record_voice_over_rounded);
    }
    return const SizedBox.shrink();
  }
}

// class _ChatQuotedMessageType extends StatelessWidget {
//   const _ChatQuotedMessageType({Key? key, required this.message}) : super(key: key);

//   final Message message;

//   @override
//   Widget build(BuildContext context) {
//     final MessageContent content = message.content;

//     if (content is MessageContentImage) {
//       return Image.asset(content.url);
//     } else if (content is MessageContentAudio) {
//       return Image.asset(content.url);
//     }
//     return const SizedBox.shrink();
//   }
// }
