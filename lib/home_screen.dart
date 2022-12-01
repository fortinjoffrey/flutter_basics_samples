import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modal bottom sheet'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    controller: ModalScrollController.of(context),
                    child: Column(
                      children: _buildContainers(),
                    ),
                  ),
                );
              },
              child: const Text('showCupertinoModalBottomSheet'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContainers() {
    return List.generate(
      10,
      (index) => Container(
        height: 200,
        color: Colors.primaries[index % Colors.primaries.length],
      ),
    );
  }
}
