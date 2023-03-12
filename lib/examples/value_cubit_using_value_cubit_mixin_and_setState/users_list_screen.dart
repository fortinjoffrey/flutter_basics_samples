import 'package:basics_samples/examples/value_cubit_using_value_cubit_mixin_and_setState/users_list_cubit.dart';

import '../../shared/data/user.dart';
import '../../shared/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_value_state/flutter_value_state.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  bool simulateErrorForNextFetching = false;
  bool simulateNoValueForNextFetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<UsersListCubit, BaseState<List<User>>>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(child: UsersList(state: state)),
                  Divider(color: Colors.black),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UsersListCubit>().loadUsers(
                            throwError: simulateErrorForNextFetching,
                            noValue: simulateNoValueForNextFetching,
                          );
                    },
                    child: const Text('Fetch user'),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
