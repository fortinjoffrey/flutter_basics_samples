import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/blocs/user_bloc.dart';
import 'package:flutter_basics_samples/blocs/user_bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Home Page'),
            ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(const UserLogoutEvent());
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/garage_page');
              },
              child: const Text('My garage'),
            ),
          ],
        ),
      ),
    );
  }
}
