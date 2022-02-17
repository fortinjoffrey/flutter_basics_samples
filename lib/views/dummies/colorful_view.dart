import 'package:flutter/material.dart';

class ColorfulView extends StatelessWidget {
  const ColorfulView({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color view'),
      ),
      body: Center(child: Container(color: color ?? Colors.red)),
    );
  }
}
