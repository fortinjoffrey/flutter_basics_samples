import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text('$index'),
          ),
        );
      },
      itemCount: 200,
    );
  }
}
