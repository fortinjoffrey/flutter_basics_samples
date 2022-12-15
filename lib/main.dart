import 'package:basics_samples/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users list'),
      ),
      body: Column(
        children: [
          Expanded(child: _UsersList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // FirebaseFirestore.instance.collection('users');
          usersRef.add(User(id: id, name: name, age: age, email: email))
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirestoreBuilder<UserQuerySnapshot>(
        ref: usersRef,
        builder: (context, AsyncSnapshot<UserQuerySnapshot> snapshot, Widget? child) {
          if (snapshot.hasError) return const Text('Something went wrong!');
          if (!snapshot.hasData) return const Text('Loading users...');

          // Access the QuerySnapshot
          UserQuerySnapshot querySnapshot = snapshot.requireData;

          return ListView.builder(
            itemCount: querySnapshot.docs.length,
            itemBuilder: (context, index) {
              // Access the User instance
              User user = querySnapshot.docs[index].data;

              return Text('User name: ${user.name}, age ${user.age}');
            },
          );
        });
  }
}
