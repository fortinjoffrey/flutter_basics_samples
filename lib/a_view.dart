import 'package:basics_samples/b_view.dart';
import 'package:flutter/material.dart';

class AView extends StatefulWidget {
  AView({Key? key,}) : super(key: key);

  

  @override
  State<AView> createState() => _AViewState();
}

class _AViewState extends State<AView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A view'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BView(),
                  ),
                );
              },
              child: const Text('Push B view'),
            ),
          ],
        ),
      ),
    );
  }
}
