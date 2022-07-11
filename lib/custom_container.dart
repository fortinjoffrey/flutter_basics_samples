import 'package:basics_samples/triangle.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Triangle(
          size: Size.square(16),
          color: Colors.red,
          direction: TriangleDirection.DOWN,
        ),
      ],
    );
  }
}
