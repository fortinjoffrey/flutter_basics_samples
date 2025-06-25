import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/card.dart';

const roseLighter = Color(0xFFFEE1F9);
const greenLighter = Color(0xFFBCEBE4);
const purpleLighter = Color(0xFFE8D3F8);
const orangeLighter = Color(0xFFFDDED9);
const blueLighter = Color(0xFFD6E3FF);

const colors = [roseLighter, greenLighter, purpleLighter, orangeLighter, blueLighter];

class Survey {
  final String id;
  final String question;

  const Survey({required this.id, required this.question});
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const spacing = 10;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final surveys = List.generate(100, (index) => Survey(id: index.toString(), question: 'Question $index'));

  final displayedSurveysCount = 3;
  int displayedIndex = 0;
  bool isCardSwipedUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        // final double cardHeight = 300;
        final cardHeight = constraints.maxHeight - MediaQuery.of(context).padding.top - (displayedSurveysCount - 1) * MainScreen.spacing;
        return Stack(
          children: [
            ...surveys
                .getRange(displayedIndex, displayedIndex + displayedSurveysCount)
                .mapIndexed((index, survey) {
                  final double topPosition = index * 10 + MediaQuery.of(context).padding.top;
                  print('index: $index, topPosition: $topPosition');
                  return Positioned(
                    top: topPosition,
                    left: 0,
                    right: 0,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: cardHeight),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: MyCard(
                          key: ValueKey(survey.id),
                          backgroundColor: colors[(displayedIndex + index) % colors.length],
                          question: survey.question,
                          swipeable: index == 0,
                          onSwipeUp: () {
                            print("swiping up");
                            setState(() {
                              isCardSwipedUp = true;
                              displayedIndex++;
                            });
                          },
                          onSwipeDown: () {
                            print("swiping down");
                            if (isCardSwipedUp) {
                              setState(() {
                                isCardSwipedUp = false;
                                displayedIndex--;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  );
                })
                .toList()
                .reversed,
            if (isCardSwipedUp)
              Positioned(
                top: -cardHeight + 50,
                left: 0,
                right: 0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: cardHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: MyCard(
                      key: ValueKey('swiped_${surveys[displayedIndex - 1].id}'),
                      backgroundColor: colors[(displayedIndex - 1) % colors.length],
                      question: surveys[displayedIndex - 1].question,
                      swipeable: false,
                      onSwipeUp: () {},
                      onSwipeDown: () {
                        setState(() {
                          isCardSwipedUp = false;
                          displayedIndex--;
                        });
                      },
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
