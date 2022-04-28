import 'package:basics_samples/model/call_item.dart';
import 'package:basics_samples/shared/constants.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  CallScreen({Key? key}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  List<CallItem> items = [
    CallItem(name: 'Bob', dateTime: 'Today, 5:54 PM', isvideoCall: false),
    CallItem(name: 'Mike', dateTime: 'Today, 8:12 AM', isvideoCall: true),
    CallItem(
        name: 'Pierre', dateTime: 'Yesterday, 9:31 AM', isvideoCall: false),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_circle, size: 64.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    items[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  items[index].dateTime,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                              items[index].isvideoCall
                                  ? Icons.videocam
                                  : Icons.call,
                              color: whatsAppGreen)
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
      },
    );
  }
}
