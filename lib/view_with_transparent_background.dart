import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

class ViewWithTransparentBackground extends StatelessWidget {
  const ViewWithTransparentBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Scaffold(
            backgroundColor: Colors.black.withOpacity(.85),
          appBar: AppBar(
            title: Text('Non opaque view'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Pop view'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}