import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/models/answer_type.dart';
import 'package:flutter_basics_samples/with_cubit/create_answers_cubit.dart';
import 'package:flutter_basics_samples/with_cubit/create_answers_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageWithCubit extends StatefulWidget {
  const HomePageWithCubit({super.key, required this.title});

  final String title;

  @override
  State<HomePageWithCubit> createState() => _HomePageWithCubitState();
}

class _HomePageWithCubitState extends State<HomePageWithCubit> {
  final List<TextEditingController> _controllers = [];
  final List<List<String>> _answerSuggestions =
      AnswerType.values.where((type) => type.suggestions != null).map((type) => type.suggestions!).toList();

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
      body: BlocProvider(
        create: (context) => CreateAnswersCubit(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<CreateAnswersCubit, CreateAnswersCubitState>(
              listenWhen: (previous, current) =>
                  previous.answerType != current.answerType || previous.answers.length != current.answers.length,
              listener: (context, state) {
                _controllers.clear();
                if (state.answerType == AnswerType.custom) {
                  _controllers.addAll(state.answers.map((answer) => TextEditingController(text: answer)));
                }
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocSelector<CreateAnswersCubit, CreateAnswersCubitState, AnswerType?>(
                  selector: (state) => state.answerType,
                  builder: (context, answerType) {
                    return Wrap(
                      spacing: 8,
                      children: _answerSuggestions
                          .mapIndexed(
                            (index, suggestion) => FilterChip(
                              selected: answerType == AnswerType.values[index],
                              label: Text(suggestion.join(' / ')),
                              onSelected: (selected) {
                                context
                                    .read<CreateAnswersCubit>()
                                    .setAnswerType(selected ? AnswerType.values[index] : null);
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                BlocSelector<CreateAnswersCubit, CreateAnswersCubitState, AnswerType?>(
                  selector: (state) => state.answerType,
                  builder: (context, answerType) {
                    return FilterChip(
                      label: const Text('Custom answer'),
                      selected: answerType == AnswerType.custom,
                      onSelected: (selected) {
                        context.read<CreateAnswersCubit>().setAnswerType(selected ? AnswerType.custom : null);
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<CreateAnswersCubit, CreateAnswersCubitState>(
                  builder: (context, state) {
                    if (state.answerType != AnswerType.custom) return const SizedBox.shrink();

                    return Column(
                      children: [
                        ...state.answers.mapIndexed((index, answer) {
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
                                          context.read<CreateAnswersCubit>().clearAnswer(index);
                                        },
                                        icon: const Icon(Icons.close))
                                    : state.answers.length > 2
                                        ? IconButton(
                                            onPressed: () {
                                              context.read<CreateAnswersCubit>().removeAnswer(index);
                                            },
                                            icon: const Icon(Icons.delete))
                                        : null,
                              ),
                              onChanged: (value) {
                                context.read<CreateAnswersCubit>().updateAnswer(value, index);
                              },
                            ),
                          );
                        }),
                        FilledButton.icon(
                          onPressed: () {
                            context.read<CreateAnswersCubit>().addAnswer();
                          },
                          label: const Text('Add answer'),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocSelector<CreateAnswersCubit, CreateAnswersCubitState, List<String>>(
                  selector: (state) => state.answers,
                  builder: (context, answers) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Answers: ${answers.length}'),
                      ...answers.mapIndexed((index, answer) => Text('\'$answer\'')),
                      Center(
                        child: Builder(
                          builder: (context) {
                            final nonEmptyAnswers = answers.where((answer) => answer.isNotEmpty).toList();
                            final hasEnoughAnswers = nonEmptyAnswers.length >= 2;

                            return FilledButton.icon(
                              onPressed: hasEnoughAnswers ? () {} : null,
                              label: const Text('Save'),
                              icon: const Icon(Icons.save),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
