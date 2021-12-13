import 'package:flutter/material.dart';

class TotalActiveFilterChip extends StatelessWidget {
  TotalActiveFilterChip({
    Key? key,
    required this.name,
    required this.activeFiltersCount,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final int activeFiltersCount;
  final VoidCallback onPressed;

  Widget build(BuildContext context) {
    return InputChip(
      label: Text(name),
      avatar: Icon(Icons.filter_list),
      onPressed: onPressed,
      deleteIcon: activeFiltersCount == 0
          ? SizedBox.shrink()
          : Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              child: Center(child: Text('$activeFiltersCount')),
            ),
      onDeleted: onPressed,
    );
  }
}
