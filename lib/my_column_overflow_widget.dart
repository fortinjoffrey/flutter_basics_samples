import 'package:flutter/material.dart';

class MyColumnOverflowWidget extends StatelessWidget {
  const MyColumnOverflowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
        Container(
          height: 200,
          width: 200,
          color: Colors.green,
        ),
        Container(
          height: 200,
          width: 200,
          color: Colors.blue,
        ),
        Container(
          height: 200,
          width: 200,
          color: Colors.red,
        ),
        Container(
          height: 200,
          width: 200,
          color: Colors.green,
        ),
        Container(
          height: 200,
          width: 200,
          color: Colors.blue,
        ),
      ],
    );
  }
}
