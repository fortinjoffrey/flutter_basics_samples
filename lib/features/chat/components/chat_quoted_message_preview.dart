import 'package:flutter/material.dart';
import 'package:swipe_to_reply/common/presentation/ui_constants.dart';
import 'package:swipe_to_reply/features/chat/models/dummy_data.dart';
import 'package:swipe_to_reply/features/chat/models/message.dart';

class ChatQuotedMessagePreview extends StatelessWidget {
  const ChatQuotedMessagePreview({Key? key, required this.message, this.onQuotedMessagePreviewClosePressed}) : super(key: key);

  final Message message;
  final VoidCallback? onQuotedMessagePreviewClosePressed;

  @override
  Widget build(BuildContext context) {
    final isFromCurrentUser = message.isFromCurrentUser(currentUser.uid);

    return Container(
      padding: const EdgeInsets.all(8.0),
      height: UIConstants.quotedMessageHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isFromCurrentUser ? Colors.green[200] : Colors.green[400],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.authorName),
                Expanded(child: _ChatQuotedMessageContent(message: message)),
              ],
            ),
          ),
          _ChatQuotedMessageType(message: message),
          IconButton(
            onPressed: onQuotedMessagePreviewClosePressed,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
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
      return Text(content.text, maxLines: 1, overflow: TextOverflow.ellipsis);
    } else if (content is MessageContentImage) {
      return const Icon(Icons.photo);
    } else if (content is MessageContentAudio) {
      return const Icon(Icons.record_voice_over_rounded);
    }
    return const SizedBox.shrink();
  }
}

class _ChatQuotedMessageType extends StatelessWidget {
  const _ChatQuotedMessageType({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final MessageContent content = message.content;

    if (content is MessageContentImage) {
      return Image.asset(content.url);
    } else if (content is MessageContentAudio) {
      return Image.asset(content.url);
    }
    return const SizedBox.shrink();
  }
}
