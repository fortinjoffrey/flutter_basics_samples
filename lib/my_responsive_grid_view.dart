import 'package:flutter/material.dart';

class MyResponsiveGridView extends StatelessWidget {
  const MyResponsiveGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 2 : 4),
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
