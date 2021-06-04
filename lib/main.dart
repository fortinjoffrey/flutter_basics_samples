import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Accept?'),
      content: Text('Are you sure?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Yes'),
        ),
      ],
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog, SnackBar, Bottom sheet'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => MyAlertDialog(),
              ),
              child: Text('Show dialog'),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    action: SnackBarAction(label: 'Undo', onPressed: () {}),
                    content: Text('A SnackBar has been shown.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              child: Text('Show snackbar'),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                        child: Text('Modal bottom sheet'),
                      ),
                    );
                  },
                );
              },
              child: Text('Show modal bottom sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
