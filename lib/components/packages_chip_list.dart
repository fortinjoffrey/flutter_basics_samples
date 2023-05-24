import 'package:flutter/material.dart';

class PackagesChipList<T extends Enum> extends StatelessWidget {
  final List<T> enumValues;
  final String Function(T) labelBuilder;
  final void Function(T) onSelected;
  final T selectedValue;

  const PackagesChipList({
    Key? key,
    required this.enumValues,
    required this.labelBuilder,
    required this.onSelected,
    required this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: enumValues.map((T value) {
          final isSelected = value == selectedValue;
    
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(labelBuilder(value)),
              selected: isSelected,
              onSelected: (isSelected) {
                if (isSelected) {
                  onSelected(value);
                }
              },
              selectedColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
