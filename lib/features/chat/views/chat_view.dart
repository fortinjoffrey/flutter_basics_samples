
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:swipe_to_reply/common/presentation/ui_constants.dart';
import 'package:swipe_to_reply/features/chat/components/chat_bottom_controls.dart';
import 'package:swipe_to_reply/features/chat/components/chat_quoted_message_preview.dart';
import 'package:swipe_to_reply/features/chat/components/chat_user_message_row.dart';
import 'package:swipe_to_reply/features/chat/models/dummy_data.dart';
import 'package:swipe_to_reply/features/chat/models/message.dart';
import 'package:swipe_to_reply/features/chat/models/message_box_border_radius_data.dart';

// TODO: widget message qui si le message à un parentId (l'id du message cité) alors rendre différemnt
// TODO: widget message qui si le message à un parentId qui supporte tous les types de messages
// TODO: ajouter le type gif, créer un bouton ouvrir GIF afficher GIF citer GIF

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  Message? quotedMessage;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat view'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: dummyMessages.length,
              itemBuilder: (context, index) {
                final Message msg = dummyMessages[index];
                final Message? previousMsg = index > 0 ? dummyMessages[index - 1] : null;
                final Message? nextMsg = index != dummyMessages.length - 1 ? dummyMessages[index + 1] : null;

                //

                final bool isCurrentUserAuthor = currentUser.name == msg.authorName;

                final data = BorderRadiusFlags(
                  isTopLeftOn: !isCurrentUserAuthor && previousMsg != null && previousMsg.authorName == msg.authorName,
                  isTopRightOn: isCurrentUserAuthor && previousMsg != null && previousMsg.authorName == msg.authorName,
                  isBottomLeftOn: !isCurrentUserAuthor && nextMsg != null && nextMsg.authorName == msg.authorName,
                  isBottomRightOn: isCurrentUserAuthor && nextMsg != null && nextMsg.authorName == msg.authorName,
                );
                // String borderRadiusCode;

                // borderRadiusCode = currentUser.name == msg.authorName ? '1' : '0';

                // // 1 ou 0

                // borderRadiusCode += (previousMsg != null && previousMsg.authorName == msg.authorName ? '1' : '0');
                // //
                // borderRadiusCode += (nextMsg != null && nextMsg.authorName == msg.authorName ? '1' : '0');

                // print(borderRadiusCode);

                return Provider<BorderRadiusFlags>.value(
                  value: data,
                  child: _MessageCell(
                    message: msg,
                    onMessageSwiped: () {
                      if (quotedMessage == null) {
                        SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
                          scrollController.animateTo(
                            scrollController.offset + UIConstants.quotedMessageHeight,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      }

                      setState(() {
                        quotedMessage = msg;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ChatBottomSection(
            quotedMessage: quotedMessage,
            onQuotedMessagePreviewClosePressed: () {
              setState(() {
                quotedMessage = null;
              });

              SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
                scrollController.animateTo(
                  scrollController.offset - UIConstants.quotedMessageHeight,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              });
            },
            onSendPressed: (messageText) {
              setState(
                () {
                  dummyMessages.add(Message(
                    quotedMessage: quotedMessage,
                    content: MessageContentText(text: messageText),
                    senderId: currentUser.uid,
                    authorName: currentUser.name,
                  ));
                  quotedMessage = null;
                },
              );
              _scrollToListBottom();
            },
            onPhotoSendPressed: () {
              setState(
                () {
                  dummyMessages.add(Message(
                    quotedMessage: quotedMessage,
                    content: MessageContentImage(url: 'assets/picture.jpeg'),
                    senderId: currentUser.uid,
                    authorName: currentUser.name,
                  ));
                  quotedMessage = null;
                },
              );
              _scrollToListBottom();
            },
            onMediaSendPressed: () {
              setState(
                () {
                  dummyMessages.add(Message(
                    quotedMessage: quotedMessage,
                    content: MessageContentAudio(url: 'assets/voice.png'),
                    senderId: currentUser.uid,
                    authorName: currentUser.name,
                  ));
                  quotedMessage = null;
                },
              );
              _scrollToListBottom();
            },
          ),
        ],
      ),
    );
  }

  void _scrollToListBottom() {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    });
  }
}

class ChatBottomSection extends StatelessWidget {
  const ChatBottomSection({
    Key? key,
    required this.onSendPressed,
    required this.onPhotoSendPressed,
    required this.onMediaSendPressed,
    required this.quotedMessage,
    this.onQuotedMessagePreviewClosePressed,
  }) : super(key: key);

  final Message? quotedMessage;
  final VoidCallback? onQuotedMessagePreviewClosePressed;
  final ValueChanged<String> onSendPressed;
  final VoidCallback onPhotoSendPressed;
  final VoidCallback onMediaSendPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(30, 30, 30, .15),
            offset: Offset(0, -4),
            blurRadius: 32,
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (quotedMessage != null)
              ChatQuotedMessagePreview(
                message: quotedMessage!,
                onQuotedMessagePreviewClosePressed: onQuotedMessagePreviewClosePressed,
              ),
            ChatBottomControls(
              onSendPressed: onSendPressed,
              onMediaSendPressed: onMediaSendPressed,
              onPhotoSendPressed: onPhotoSendPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageCell extends StatelessWidget {
  const _MessageCell({
    Key? key,
    required this.message,
    this.onMessageSwiped,
  }) : super(key: key);

  final Message message;
  final VoidCallback? onMessageSwiped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SwipeTo(
        onRightSwipe: onMessageSwiped,
        child: ChatUserMessageRow(message: message),
      ),
    );
  }
}
