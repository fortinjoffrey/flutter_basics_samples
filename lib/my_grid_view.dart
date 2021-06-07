import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text('$index'),
          ),
        );
      },
    );
  }
}
