import 'package:flutter/material.dart';

class MyColumnWithExpandedWidget extends StatelessWidget {
  const MyColumnWithExpandedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.red,
            child: Center(
              child: Text('Hello from Red'),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.green,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.purple,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
