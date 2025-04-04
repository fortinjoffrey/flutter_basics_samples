import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/models/answer_type.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _answers = [];
  final List<TextEditingController> _controllers = [];
  final List<List<String>> _answerSuggestions =
      AnswerType.values.where((type) => type.suggestions != null).map((type) => type.suggestions!).toList();
  AnswerType? _answerType;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 8,
              children: _answerSuggestions
                  .mapIndexed((index, suggestion) => FilterChip(
                      selected: _answerType == AnswerType.values[index],
                      label: Text(suggestion.join(' / ')),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _answerType = AnswerType.values[index];
                            _answers = _answerType!.suggestions!;
                            _controllers.clear();
                            _controllers.addAll(_answers.map((answer) => TextEditingController(text: answer)));
                          } else {
                            _answerType = null;
                            _answers = [];
                            _controllers.clear();
                          }
                        });
                      }))
                  .toList(),
            ),
            FilterChip(
                label: const Text('Custom answer'),
                onSelected: (selected) {
                  setState(() {
                    _answerType = selected ? AnswerType.custom : null;
                    _answers = ['', ''];
                    _controllers.clear();
                    _controllers.addAll(_answers.map((answer) => TextEditingController(text: answer)));
                  });
                }),
            const SizedBox(height: 16),
            if (_answerType == AnswerType.custom)
              ..._answers.mapIndexed(
                (index, answer) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Answer ${index + 1}',
                        suffixIcon: _controllers[index].text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _controllers[index].clear();
                                  setState(() {
                                    _answers[index] = '';
                                  });
                                },
                                icon: const Icon(Icons.close))
                            : index >= 2
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _answers.removeAt(index);
                                        _controllers.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.delete))
                                : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _answers[index] = value;
                        });
                      },
                    ),
                  );
                },
              ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: FilledButton.icon(
                onPressed: () {
                  setState(() {
                    _answers.add('');
                    _controllers.add(TextEditingController());
                  });
                },
                label: const Text('Add answer'),
                icon: const Icon(Icons.add),
              ),
            ),
            const SizedBox(height: 16),
            ..._answers.mapIndexed((index, answer) => Text(answer)),
          ],
        ),
      ),
    );
  }
}
