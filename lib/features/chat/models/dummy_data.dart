import 'dart:math';

import 'package:swipe_to_reply/common/models/user.dart';
import 'package:swipe_to_reply/features/chat/models/message.dart';

const User currentUser = User(name: 'John', uid: 0);

final List<Message> dummyMessages = List.generate(
  20,
  (index) {
    final senderId = Random().nextInt(2);
    final msgTypeIndex = Random().nextInt(3);
    final loremChoice = Random().nextBool();
    const shortLorem = 'Nulla in voluptate elit.';
    const longLorem = 'Non est dolor sit ipsum Lorem enim eiusmod duis. Duis tempor elit ut anim aute adipisicing commodo laborum ea. Sit sint est amet est ea sunt sunt duis irure.';

    late MessageContent content;

    switch (msgTypeIndex) {
      case 0:
        content = MessageContentText(text: loremChoice ? shortLorem : longLorem);
        break;
      case 1:
        content = MessageContentImage(url: 'assets/picture.jpeg');
        break;
      case 2:
        content = MessageContentAudio(url: 'assets/voice.png');
        break;
    }

    return Message(
      content: content,
      senderId: senderId,
      authorName: senderId == currentUser.uid ? currentUser.name : 'Jane',
    );
  },
);
