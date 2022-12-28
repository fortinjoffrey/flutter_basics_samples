import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slivers'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text('Index: $index'),
                  tileColor: Colors.primaries[index % Colors.primaries.length],
                );
              },
              childCount: 5,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverToBoxAdapter(
              child: Text('Lorem ipsum Nostrud esse irure consectetur commodo minim cupidatat. Tempor enim laborum tempor aute pariatur minim id proident.'),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: 200,
                color: Colors.yellow,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 50,
                      child: Card(
                        color: Colors.primaries[index % Colors.primaries.length],
                        child: Center(child: Text(index.toString())),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                )),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return SizedBox(
                  child: Card(
                    color: Colors.primaries[index % Colors.primaries.length],
                    child: Center(
                      child: Text('Index: $index'),
                    ),
                  ),
                );
              }),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2))
        ],
      ),
    );
  }
}
