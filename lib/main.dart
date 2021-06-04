import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'person_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ParentWidget(),
    );
  }
}

class ParentWidget extends StatelessWidget {
  const ParentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonModel(26, 'Gordon'),
      child: Scaffold(
        appBar: AppBar(title: Text('Parent Widget')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterWidget(),
              NameWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<PersonModel>(
          builder: (context, model, child) => Column(
            children: [
              Text('${model.counter}'),
              child!,
            ],
          ),
          child: MyExpensiveWidget(),
        ),
        ElevatedButton.icon(
          label: Text('Increment'),
          icon: Icon(Icons.add),
          onPressed: () => context.read<PersonModel>().increment(),
        ),
      ],
    );
  }
}

class MyExpensiveWidget extends StatelessWidget {
  const MyExpensiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NameWidget extends StatefulWidget {
  NameWidget({Key? key}) : super(key: key);

  @override
  _NameWidgetState createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  late PersonModel myModel;

  @override
  void initState() {
    super.initState();
    myModel = context.read<PersonModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Text(myModel.name);
  }
}
