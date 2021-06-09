import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'person.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Person(name: 'Gordon'),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late String name;

  @override
  void initState() {
    super.initState();
    name = context.read<Person>().name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parent Widget')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Hello $name',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            Text(
              'Choose a favorite color',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1),
                itemBuilder: (context, index) {
                  final color = Colors.primaries[index % Colors.primaries.length];

                  return GestureDetector(
                    onTap: () {
                      context.read<Person>().changeFavoriteColor(color);
                    },
                    child: Container(
                      color: color,
                      child: Center(
                        child: Text('$index'),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FavoriteColorWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteColorWidget extends StatelessWidget {
  const FavoriteColorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
          child: Text(
            'Your favorite color is: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Selector<Person, Color?>(
          builder: (context, color, child) {
            return Container(
              color: color ?? Colors.transparent,
              height: 50,
              width: 50,
            );
          },
          selector: (context, person) => person.favoriteColor,
        ),
      ],
    );
  }
}
