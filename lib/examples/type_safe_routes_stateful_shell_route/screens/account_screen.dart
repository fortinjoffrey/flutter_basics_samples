import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/examples/type_safe_routes_stateful_shell_route/router/router.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
              onPressed: () {
                // const AccountDetailsRoute(id: 'id', age: 18).go(context);
                const HomeSearchRoute().go(context);
              },
              child: const Text('View details'),
            ),
            // const Padding(padding: EdgeInsets.all(4)),
            // if (secondDetailsPath != null)
            //   TextButton(
            //     onPressed: () {
            //       GoRouter.of(context).go(secondDetailsPath!);
            //     },
            //     child: const Text('View more details'),
            //   ),
          ],
        ),
      ),
    );
  }
}
