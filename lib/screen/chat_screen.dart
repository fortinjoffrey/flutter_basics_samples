import 'package:basics_samples/model/chat_item.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatItemModel> items = [
    ChatItemModel(
        name: 'John',
        messageDate: '18/07/2020',
        mostRecentMessage: 'Lunch at 1:00 PM?'),
    ChatItemModel(
        name: 'Jane',
        messageDate: '17/07/2020',
        mostRecentMessage: 'You\'re absolutely right'),
    ChatItemModel(
      name: 'Sam',
      messageDate: '10/07/2020',
      mostRecentMessage: 'Wanna go?',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 64.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  items[index].messageDate,
                                  style: TextStyle(color: Colors.black45),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                items[index].mostRecentMessage,
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
            ],
          );
        });
  }
}
