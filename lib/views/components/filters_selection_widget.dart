import 'package:flutter/material.dart';

import '../../models/filter.dart';
import '../../models/filter_group.dart';
import 'filters_group_widget.dart';

class FiltersSelectionWidget extends StatefulWidget {
  const FiltersSelectionWidget({
    Key? key,
    required this.selectableFilters,
    this.onApplyTapped,
    this.onRemoveAllTapped,
  }) : super(key: key);

  final List<FilterGroup> selectableFilters;
  final ValueChanged<List<FilterGroup>>? onApplyTapped;
  final VoidCallback? onRemoveAllTapped;

  @override
  State<FiltersSelectionWidget> createState() => _FiltersSelectionWidgetState();
}

class _FiltersSelectionWidgetState extends State<FiltersSelectionWidget> {
  late List<FilterGroup> selectedFilters;

  @override
  void initState() {
    super.initState();
    selectedFilters = widget.selectableFilters;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
        color: Colors.white,
      ),
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    height: 4,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: SizedBox.shrink(),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Select filters',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                const SizedBox(height: 20),
                ...selectedFilters
                    .map(
                      (filterGroup) => FiltersGroupWidget(
                        groupName: filterGroup.name,
                        filters: filterGroup.filters,
                        onFilterChange: (filter) => onFilterChange(filter, filterGroup),
                      ),
                    )
                    .toList(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.onRemoveAllTapped?.call();
                        clearSelectedFilters();
                      },
                      child: const Text('Effacer les filtres'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.onApplyTapped?.call(selectedFilters);
                      },
                      child: const Text('Appliquer'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearSelectedFilters() {
// Set selected to false for every filter of every group
    final updatedSelectedFilters = List<FilterGroup>.from(selectedFilters)
        .map((group) => group.copyWith(
              filters: group.filters.map((f) => f.copyWith(selected: false)).toList(),
            ))
        .toList();

    setState(() {
      selectedFilters = updatedSelectedFilters;
    });
  }

  void onFilterChange(Filter filter, FilterGroup filterGroup) {
    // 1. Update filter in its filterGroup
    final updatedFilters = List<Filter>.from(filterGroup.filters);
    final index = updatedFilters.indexWhere((e) => e.name == filter.name);
    updatedFilters[index] = filter;

    // 2. Update the filter group
    final updatedSelectedFilters = List<FilterGroup>.from(selectedFilters);
    final groupIndex = updatedSelectedFilters.indexWhere((e) => e.name == filterGroup.name);
    updatedSelectedFilters[groupIndex] = filterGroup.copyWith(filters: updatedFilters);

    setState(() {
      selectedFilters = updatedSelectedFilters;
    });
  }
}
