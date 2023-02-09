import 'package:basics_samples/data/firebase_functions_source.dart';
import 'package:basics_samples/presentation/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthStore authStore;

  @override
  void initState() {
    super.initState();
    authStore = context.read<AuthStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Observer(
                builder: (context) {
                  final currentUser = authStore.currentUser;
                  if (currentUser == null) return Text('currentUser = null');
                  return Column(
                    children: [
                      Text('email = ${currentUser.email ?? 'null'}'),
                      Text('isAnonymous = ${currentUser.isAnonymous}'),
                      Text('uid = ${currentUser.uid}'),
                    ],
                  );
                },
              ),
              Observer(builder: (_) {
                return TextButton(
                  onPressed: authStore.currentUser == null
                      ? () async {
                          authStore.signInAnonymously();
                        }
                      : null,
                  child: const Text('Sign in anonymously'),
                );
              }),
              Observer(builder: (_) {
                return TextButton(
                  onPressed: authStore.currentUser != null && authStore.currentUser!.isAnonymous
                      ? () async {
                          authStore.signInWithEmail();
                        }
                      : null,
                  child: const Text('Sign in with email'),
                );
              }),
              Observer(builder: (_) {
                return TextButton(
                  onPressed: authStore.currentUser != null
                      ? () async {
                          authStore.signOut();
                        }
                      : null,
                  child: const Text('Sign out'),
                );
              }),
              TextButton(
                onPressed: () {
                  context.read<FirebaseFunctionsSource>().migrateExistingPollToPollWithCreatedDate();
                },
                child: const Text('migrateExistingPollToPollWithCreatedDate'),
              ),
            ],
          ),
        ));
  }
}
