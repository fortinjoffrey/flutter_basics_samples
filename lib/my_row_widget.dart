import 'package:flutter/material.dart';

class MyRowWidget extends StatelessWidget {
  const MyRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
