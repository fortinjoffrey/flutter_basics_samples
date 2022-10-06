import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  void _makeAnnouncement(String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Text("announce"),
            onPressed: () => _makeAnnouncement("Announcement made"),
          ),
        ),
      ),
    );
  }
}
