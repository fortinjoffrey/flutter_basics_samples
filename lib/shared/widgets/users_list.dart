import '../data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_value_state/flutter_value_state.dart';

class UsersList extends StatelessWidget {
  const UsersList({required this.state});

  final BaseState<List<User>> state;

  @override
  Widget build(BuildContext context) {
    return state.buildWidget(
      valueMixedWithError: true,
      wrapper: (context, state, child) {
        return Column(
          children: [
            if (state.fetching) ...[
              LinearProgressIndicator(),
            ],
            const SizedBox(height: 8),
            Expanded(child: child),
          ],
        );
      },
      onError: (context, state) {
        if (state.refreshing) return const SizedBox.shrink();
        return Text('An error occured, please try again');
      },
      onNoValue: (context, state) {
        return Text('No users');
      },
      onWaiting: (context, state) {
        return Center(
          child:
              state is InitState ? Text('Tap the button below to start fetching users') : CircularProgressIndicator(),
        );
      },
      onValue: (context, state, error) {
        final users = state.value;

        return Column(
          children: [
            if (state.hasError && error != null) ...[
              error,
              const SizedBox(height: 8),
            ],
            Expanded(
              child: Material(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final userName = users[index].name;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.primaries[index % Colors.primaries.length],
                          child: Text(userName[0]),
                        ),
                        title: Text(userName),
                        tileColor: Colors.grey[200],
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          )
                          // borderSide: BorderSide(
                          //   color: Colors.primaries[index % Colors.primaries.length],
                          //   width: 2,
                          // ),
                        ),
                      ),
                    );
                  },
                  itemCount: users.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
