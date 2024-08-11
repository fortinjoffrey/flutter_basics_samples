import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/widgets/auto_scroll_widget.dart';

class CustomScrollViewAutoScrollPage extends StatefulWidget {
  const CustomScrollViewAutoScrollPage({super.key});

  @override
  State<CustomScrollViewAutoScrollPage> createState() => _CustomScrollViewAutoScrollPageState();
}

class _CustomScrollViewAutoScrollPageState extends State<CustomScrollViewAutoScrollPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(200, (i) => "Item $i");

    return AutoScrollWidget(
      scrollController: scrollController,
      child: Scaffold(
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
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ListTile(
                              title: Column(
                                children: [
                                  Text(items[index]),
                                ],
                              ),
                            );
                          },
                          childCount: items.length,
                        ),
                      ),
                    ],
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
