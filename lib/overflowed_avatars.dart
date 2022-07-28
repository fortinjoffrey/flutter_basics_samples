import 'package:flutter/material.dart';
import 'package:overflow_view/overflow_view.dart';

class OverflowedAvatars extends StatelessWidget {
  const OverflowedAvatars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverflowView.flexible(
      builder: (context, remainingItemCount) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(child: Text('+$remainingItemCount')),
        );
      },
      children: [
        for (int i = 0; i < 10; i++)
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              child: Text(i.toString()),
            ),
          ),
      ],
    );
  }
}
