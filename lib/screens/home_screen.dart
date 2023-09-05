import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/main.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => context.go('/detail'),
                child: const CenteredText('go /detail'),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () => context.push('/detail'),
                child: const CenteredText('push /detail'),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () => context.go('/modal'),
                child: const CenteredText('go /modal'),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () => context.go(
                  context.namedLocation(
                    'person',
                    pathParameters: <String, String>{'id': '123', 'name': 'John'},
                  ),
                ),
                child: const CenteredText('go /person/123'),
                //  onTap: () => context.go(context.namedLocation('family',
                // pathParameters: <String, String>{'fid': entry.key})),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
