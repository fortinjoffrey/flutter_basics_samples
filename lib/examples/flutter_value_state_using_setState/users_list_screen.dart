import '../../shared/data/fake_data_source.dart';
import '../../shared/data/user.dart';
import '../../shared/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_value_state/flutter_value_state.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  BaseState<List<User>> getUsersState = const InitState<List<User>>();
  bool simulateErrorForNextFetching = false;
  bool simulateNoValueForNextFetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: UsersList(state: getUsersState)),
            Divider(color: Colors.black),
            ElevatedButton(
              onPressed: () {
                getUsersState.perform((state) async {
                  return FakeDataSource()
                      .getUsers(
                        throwError: simulateErrorForNextFetching,
                        noValue: simulateNoValueForNextFetching,
                      )
                      .toFutureState();
                }).listen((state) {
                  setState(() {
                    getUsersState = state;
                  });
                });
              },
              child: const Text('Fetch users'),
            ),
            SwitchListTile(
              value: simulateErrorForNextFetching,
              onChanged: (value) {
                setState(() {
                  simulateErrorForNextFetching = !simulateErrorForNextFetching;
                });
              },
              title: Text('Simulate error for next fetching'),
            ),
            SwitchListTile(
              value: simulateNoValueForNextFetching,
              onChanged: (value) {
                setState(() {
                  simulateNoValueForNextFetching = !simulateNoValueForNextFetching;
                });
              },
              title: Text('Simulate no value for next fetching'),
            ),
          ],
        ),
      ),
    );
  }
}