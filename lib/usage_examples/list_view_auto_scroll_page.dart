import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/widgets/auto_scroll_widget.dart';

class ListViewAutoScrollPage extends StatefulWidget {
  const ListViewAutoScrollPage({super.key});

  @override
  State<ListViewAutoScrollPage> createState() => _ListViewAutoScrollPageState();
}

class _ListViewAutoScrollPageState extends State<ListViewAutoScrollPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(200, (i) => "Item $i");

    return AutoScrollWidget(
      scrollController: scrollController,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('ListView with TextField'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
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
      ),
    );
  }
}
