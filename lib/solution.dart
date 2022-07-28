import 'package:flutter/material.dart';

import 'overflowed_avatars.dart';

class Solution extends StatelessWidget {
  const Solution({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
          },
          border: const TableBorder(
            verticalInside: BorderSide(color: Colors.white),
          ),
          children: [
            TableRow(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('15:00'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      OverflowedAvatars(),
                      OverflowedAvatars(),
                      OverflowedAvatars(),
                      OverflowedAvatars(),
                      OverflowedAvatars(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
