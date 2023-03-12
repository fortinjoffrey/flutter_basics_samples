// import 'package:basics_samples/examples/value_cubit_using_value_cubit_mixin_and_setState/users_list_cubit.dart';
// import 'package:basics_samples/examples/value_cubit_using_value_cubit_mixin_and_setState/users_list_screen.dart';
import 'package:basics_samples/examples/value_cubit_using_custom_state/users_list_cubit.dart';
import 'package:basics_samples/examples/value_cubit_using_custom_state/users_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'examples/flutter_value_state_using_setState/users_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => UsersListCubit(),
        child: UsersListScreen(),
      ),
      // home: UsersListScreen(),
    );
  }
}
