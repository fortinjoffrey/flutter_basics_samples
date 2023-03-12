import 'package:basics_samples/examples/value_cubit_using_custom_state/users_list_cubit.dart';
import 'package:basics_samples/examples/value_cubit_using_custom_state/users_list_state.dart';

import '../../shared/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<UsersListCubit, UsersListState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(child: UsersList(state: state.getUsersState)),
                  Divider(color: Colors.black),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UsersListCubit>().loadUsers();
                    },
                    child: const Text('Fetch user'),
                  ),
                  SwitchListTile(
                    value: state.simulateErrorForNextFetching,
                    onChanged: (_) {
                      context.read<UsersListCubit>().toggleSimulateErrorForNextFetching();
                    },
                    title: Text('Simulate error for next fetching'),
                  ),
                  SwitchListTile(
                    value: state.simulateNoValueForNextFetching,
                    onChanged: (_) {
                      context.read<UsersListCubit>().toggleSimulateNoValueForNextFetching();
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
