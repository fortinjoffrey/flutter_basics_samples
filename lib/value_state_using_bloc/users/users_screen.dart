import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/shared/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_state/value_state.dart';

import 'bloc/users_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          actions: [
            BlocBuilder<UsersBloc, UsersBlocState>(
              builder: (context, state) {
                return IconButton(
                  onPressed:
                      state.usersState.isFetching ? null : () => context.read<UsersBloc>().add(ResetStateEvent()),
                  icon: const Icon(Icons.restore),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<UsersBloc, UsersBlocState>(
                listenWhen: (previous, current) => previous.usersState.isFetching && current.usersState.isFailure,
                listener: (context, state) {
                  if (state.usersState.isFailure) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error fetching users')),
                    );
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<UsersBloc, UsersBlocState>(
                    builder: (context, state) {
                      switch (state.usersState) {
                        case Value(
                            isFetching: true,
                            data: null,
                          ):
                          return const Center(child: CircularProgressIndicator());

                        case Value(
                            isInitial: true,
                          ):
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text('Tap the button below to start fetching users'),
                                  ),
                                ),
                                Divider(),
                                SafeArea(
                                  child: ElevatedButton(
                                    onPressed: () => context.read<UsersBloc>().add(GetUsersEvent()),
                                    child: const Text('Fetch Users'),
                                  ),
                                ),
                              ],
                            ),
                          );

                        case Value(
                            isFailure: true,
                            data: == null,
                            :final bool isRefetching,
                          ):
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isRefetching)
                                  const LinearProgressIndicator()
                                else
                                  ElevatedButton(
                                    onPressed: () => context.read<UsersBloc>().add(GetUsersEvent()),
                                    child: const Text('Retry'),
                                  ),
                                if (!isRefetching) Text('An error occurred while fetching users'),
                              ],
                            ),
                          );

                        case Value(
                            :final List<User>? data,
                            :final bool isRefetching,
                          ):
                          if (data == null) {
                            return const Center(child: Text('No data'));
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (isRefetching) const LinearProgressIndicator(),
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    context.read<UsersBloc>().add(GetUsersEvent());
                                  },
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverList.builder(
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          final user = data[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Material(
                                              child: ListTile(
                                                trailing: IconButton(
                                                  onPressed: isRefetching
                                                      ? null
                                                      : () => context.read<UsersBloc>().add(DeleteUserEvent(user)),
                                                  icon: const Icon(Icons.delete_forever_outlined),
                                                ),
                                                leading: CircleAvatar(
                                                  backgroundColor: Colors.primaries[index % Colors.primaries.length],
                                                  child: Text(user.name[0]),
                                                ),
                                                title: Text(user.name),
                                                tileColor: Colors.grey[200],
                                                shape: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SliverToBoxAdapter(
                                        child: Center(
                                          child: ElevatedButton(
                                            onPressed: isRefetching
                                                ? null
                                                : () => context.read<UsersBloc>().add(AddUserEvent()),
                                            child: const Text('Add user'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                      }
                    },
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Simulate error for next fetching'),
                    BlocBuilder<UsersBloc, UsersBlocState>(
                      builder: (context, state) {
                        return Switch(
                          value: state.simulateError,
                          onChanged: (_) {
                            context.read<UsersBloc>().add(ToggleSimulateErrorEvent());
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
