import 'package:basics_samples/datasource/remote_source_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/filter_group.dart';
import 'components/chips/total_filters_chip.dart';
import 'components/filters_selection_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({
    Key? key,
    this.onApplied,
    this.selectableFilters,
  }) : super(key: key);

  final VoidCallback? onApplied;
  final List<FilterGroup>? selectableFilters;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late int activeFiltersCount;
  late List<FilterGroup> selectedFilters;

  @override
  void initState() {
    super.initState();
    selectedFilters = widget.selectableFilters ?? RemoteSourceImpl.fetchFiltersGroups();
    activeFiltersCount = _getActiveFiltersCount(selectedFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search view'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue.withOpacity(.2),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      TotalActiveFilterChip(
                        name: 'Filters',
                        activeFiltersCount: activeFiltersCount,
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return FiltersSelectionWidget(
                                selectableFilters: selectedFilters,
                                onApplyTapped: (updatedFilters) {
                                  // Dismiss the modal
                                  Navigator.of(context).pop();

                                  setState(() {
                                    selectedFilters = updatedFilters;
                                    activeFiltersCount = _getActiveFiltersCount(selectedFilters);
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getActiveFiltersCount(List<FilterGroup> filtersGroups) {
    int activeCount = 0;
    filtersGroups.forEach(
      (group) => activeCount += group.filters.where((filter) => filter.selected).toList().length,
    );
    return activeCount;
  }
}
