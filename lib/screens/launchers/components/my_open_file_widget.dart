import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

class MyOpenFileWidget extends StatelessWidget {
  const MyOpenFileWidget({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final result = await OpenFilex.open(path);
            print(result);
          },
          child: const Text('Open PDF file (downloaded)'),
        ),
      ],
    );
  }
}
