import 'dart:math';

import '../models/user.dart';

class FakeDataSource {
  static const _names = [
    'Olivia',
    'Ethan',
    'Sophia',
    'Liam',
    'Isabella',
  ];

  static final List<User> _users = List.generate(
    _names.length,
    (i) => User(name: _names[i], age: Random().nextInt(70), id: i.toString()),
  );

  Future<List<User>> getUsers({
    bool throwError = false,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (throwError) throw Exception();
    return _users;
  }
}
