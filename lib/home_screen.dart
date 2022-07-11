import 'package:basics_samples/usecases.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accessibility usecases'),
      ),
      body: ListView.builder(
        itemCount: usecases.length,
        itemBuilder: (BuildContext context, int index) {
          final usecase = usecases[index];
          return _AccessibilityUsecaseCell(usecase, index + 1);
        },
      ),
    );
  }
}

class _AccessibilityUsecaseCell extends StatelessWidget {
  const _AccessibilityUsecaseCell(this.usecase, this.index, {Key? key}) : super(key: key);

  final Usecase usecase;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Semantics(
        child: GestureDetector(
          onTap: () {
            final demoWidget = usecase.demoWidget;
            if (demoWidget != null) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => demoWidget));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text('$index'),
                  backgroundColor: Colors.primaries[index % Colors.primaries.length],
                  foregroundColor: Colors.white,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        usecase.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...usecase.testConditions.map(
                        (condition) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('\u2022 $condition'),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
