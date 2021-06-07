import 'package:flutter/material.dart';

class MyStackWidget extends StatelessWidget {
  const MyStackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500,
          width: 500,
          color: Colors.red,
        ),
        Container(
          height: 250,
          width: 250,
          color: Colors.green,
        ),
        Container(
          height: 100,
          width: 100,
          color: Colors.blue,
        ),
      ],
    );
  }
}
