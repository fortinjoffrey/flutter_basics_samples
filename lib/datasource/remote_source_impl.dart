import '../models/filter_group.dart';

class RemoteSourceImpl {
  static List<FilterGroup> fetchFiltersGroups() {
    final fakeJson = <String, dynamic>{
      'body': [
        {
          'name': 'Languages',
          'filters': [
            {'name': 'C++'},
            {'name': 'Dart', 'selected': true},
          ],
        },
        {
          'name': 'Companies',
          'filters': [
            {'name': 'Facebook'},
            {'name': 'Google', 'selected': false},
          ],
        },
      ],
    };

    final groups = fakeJson['body'] as List<dynamic>;
    return groups.map((e) => FilterGroup.fromMap(e as Map<String, dynamic>)).toList();
  }
}
