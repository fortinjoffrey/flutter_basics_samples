import 'user.dart';

class FakeDataSource {
  static const names = ['Olivia', 'Ethan', 'Sophia', 'Liam', 'Isabella', 'Noah', 'Mia', 'Jackson', 'Emma', 'Lucas'];
  static const ages = [29, 42, 18, 36, 25, 52, 21, 47, 30, 19];
  static final List<User> _users = List.generate(
    10,
    (i) => User(name: names[i], age: ages[i]),
  );

  Future<List<User>?> getUsers({
    bool throwError = false,
    bool noValue = false,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (throwError) throw 'Exception';
    if (noValue) return null;
    return _users;
  }
}
