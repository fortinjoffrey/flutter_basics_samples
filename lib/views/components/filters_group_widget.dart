import 'package:flutter/material.dart';

import '../../models/filter.dart';

class FiltersGroupWidget extends StatelessWidget {
  FiltersGroupWidget({
    Key? key,
    required this.groupName,
    required this.filters,
    this.onFilterChange,
  }) : super(key: key);

  final String groupName;
  final List<Filter> filters;
  final ValueChanged<Filter>? onFilterChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(groupName),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 10,
          children: filters
              .map(
                (filter) => FilterChip(
                  label: Text(filter.name),
                  selected: filter.selected,
                  onSelected: onFilterChange == null
                      ? null
                      : (value) {
                          onFilterChange?.call(
                            Filter(name: filter.name, selected: value),
                          );
                        },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
