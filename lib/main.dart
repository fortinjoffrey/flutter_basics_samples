import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _redFlexValue = 1;
  int _blueFlexValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercice'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  flex: _blueFlexValue,
                  child: Container(
                    color: Colors.blue,
                    child: const Center(child: Text('Blue')),
                  ),
                ),
                Expanded(
                  flex: _redFlexValue,
                  child: Container(
                    color: Colors.red,
                    child: const Center(child: Text('Red')),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.green,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    setState(() => _blueFlexValue++);
                  },
                  child: const Text('Expanded blue flex'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    setState(() => _redFlexValue++);
                  },
                  child: const Text('Expanded red flex'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('My index is: $index'),
                  tileColor: Colors.primaries[index % Colors.primaries.length],
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () {
                  setState(() {
                    _redFlexValue = 1;
                    _blueFlexValue = 1;
                  });
                },
                child: const Text('Reset flex numbers red flex'),
              ),
            ),
          )
          // Expanded(
          //   child: Center(child: Text('Helo')),
          // )
        ],
      ),
    );
  }
}
