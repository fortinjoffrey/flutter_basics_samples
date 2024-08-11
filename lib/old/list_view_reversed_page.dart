import 'package:flutter/material.dart';

class ListViewReversedPage extends StatefulWidget {
  const ListViewReversedPage({super.key});

  @override
  State<ListViewReversedPage> createState() => _ListViewReversedPageState();
}

class _ListViewReversedPageState extends State<ListViewReversedPage> with WidgetsBindingObserver {


 
  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(200, (i) => "Item $i");

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Auto scroll'),
      ),
     
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  reverse: true,
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                    height: 2,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        children: [
                          Text(items[index]),
                        ],
                      ),
                    );
                  },
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter your text here',
                ),
                onSubmitted: (text) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
