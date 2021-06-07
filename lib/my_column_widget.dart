import 'package:flutter/material.dart';

class MyColumnWidget extends StatelessWidget {
  const MyColumnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
