import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_basics_samples/bloc/surveys_state.dart';
import 'package:flutter_basics_samples/models/survey.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_basics_samples/bloc/surveys_bloc.dart';
import 'package:flutter_basics_samples/bloc/surveys_event.dart';
import 'package:flutter_basics_samples/survey_card.dart';
import 'package:value_state/value_state.dart';

const roseLighter = Color(0xFFFEE1F9);
const greenLighter = Color(0xFFBCEBE4);
const purpleLighter = Color(0xFFE8D3F8);
const orangeLighter = Color(0xFFFDDED9);
const blueLighter = Color(0xFFD6E3FF);

const colors = [roseLighter, greenLighter, purpleLighter, orangeLighter, blueLighter];

// final surveys =
//     List.generate(3, (index) => Survey(id: index.toString(), question: 'Question $index', displayResults: false));

const displayedSurveysCount = 3;

const spacing = 10;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int displayedIndex = 0;
  double offsetY = 0;
  late final AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _othersAnimation;
  bool isAnimating = false;
  double othersOffsetY = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurveysBloc()..add(LoadSurveysEvent()),
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          final cardHeight =
              constraints.maxHeight - MediaQuery.of(context).padding.top - (displayedSurveysCount - 1) * spacing;

          return BlocBuilder<SurveysBloc, SurveysState>(
            builder: (context, state) {
              switch (state.surveysState) {
                case Value(data: final List<Survey> surveys):
                  return Stack(
                    children: [
                      // Fake card de fin (cachée en bas quand on est sur la dernière vraie carte)
                      if (displayedIndex >= surveys.length - 1)
                        Positioned(
                          top: MediaQuery.of(context).padding.top +
                              (displayedSurveysCount - 1) * spacing, // Même position que les cartes cachées
                          left: 0,
                          right: 0,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: cardHeight),
                            child: GestureDetector(
                              onVerticalDragUpdate: (displayedIndex >= surveys.length)
                                  ? (details) => _onVerticalDragUpdate(details, surveys)
                                  : null,
                              onVerticalDragEnd: (displayedIndex >= surveys.length)
                                  ? (details) => _onVerticalDragEnd(details, cardHeight, surveys, context)
                                  : null,
                              child: SurveyCard(
                                question: "🎉 Fin des questions !\n\nSwipez vers le bas pour revenir",
                                backgroundColor: Colors.grey[300]!,
                              ),
                            ),
                          ),
                        ),
                      ...surveys
                          .getRange(
                              math.max(0, displayedIndex > 0 ? displayedIndex - 1 : displayedIndex),
                              math.min(
                                  surveys.length,
                                  (displayedIndex > 0 ? displayedIndex - 1 : displayedIndex) +
                                      displayedSurveysCount +
                                      1 +
                                      (displayedIndex > 0 ? 1 : 0)))
                          .mapIndexed((localIndex, survey) {
                            final double baseTopPosition;

                            if (localIndex == 0 && displayedIndex > 0) {
                              // Carte précédente : cachée en haut (position de base)
                              baseTopPosition = -cardHeight + 30;
                            } else {
                              // Calcul de l'index d'affichage réel
                              final displayIndex = displayedIndex > 0 ? localIndex - 1 : localIndex;

                              if (displayIndex >= displayedSurveysCount) {
                                // Dernière carte : même position que l'avant-dernière (cachée derrière)
                                baseTopPosition = MediaQuery.of(context).padding.top;
                              } else {
                                // Cartes normales
                                baseTopPosition = (displayedSurveysCount - displayIndex - 1) * spacing +
                                    MediaQuery.of(context).padding.top;
                              }
                            }

                            return Positioned(
                              top: baseTopPosition, // Position de base uniquement
                              left: 0,
                              right: 0,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: cardHeight),
                                child: GestureDetector(
                                  onVerticalDragUpdate: _isCurrentCard(localIndex)
                                      ? (details) => _onVerticalDragUpdate(details, surveys)
                                      : null,
                                  onVerticalDragEnd: _isCurrentCard(localIndex)
                                      ? (details) => _onVerticalDragEnd(details, cardHeight, surveys, context)
                                      : null,
                                  child: Builder(builder: (context) {
                                    final globalIndex = displayedIndex > 0
                                        ? displayedIndex - 1 + localIndex
                                        : displayedIndex + localIndex;
                                    final card = SurveyCard(
                                      question: survey.question,
                                      backgroundColor: colors[globalIndex % colors.length],
                                    );

                                    // Calcul des offsets dynamiques pour chaque carte
                                    double dynamicOffsetY = 0;

                                    if (localIndex == 0 && displayedIndex > 0) {
                                      // Carte précédente : suit tous les mouvements de drag
                                      dynamicOffsetY = offsetY;
                                    } else if (_isCurrentCard(localIndex)) {
                                      // Carte courante : seulement swipe up
                                      dynamicOffsetY = offsetY < 0 ? offsetY : 0;
                                    } else {
                                      // Autres cartes : suivent othersOffsetY (sauf cartes cachées)
                                      final bool isHiddenCard = displayedIndex > 0
                                          ? (localIndex - 1) >= displayedSurveysCount
                                          : localIndex >= displayedSurveysCount;
                                      if (!isHiddenCard) {
                                        dynamicOffsetY = othersOffsetY;
                                      }
                                    }

                                    return Transform.translate(
                                      offset: Offset(0, dynamicOffsetY),
                                      child: card,
                                    );
                                  }),
                                ),
                              ),
                            );
                          })
                          .toList()
                          .reversed,
                    ],
                  );
                case Value(isInitial: true):
                case Value(isFetching: true):
                  return const Center(child: CircularProgressIndicator());
                case Value(hasError: true):
                  return const Center(child: Text('Error'));
                default:
                  return const SizedBox.shrink();
              }
            },
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }

  void _onVerticalDragEnd(
    DragEndDetails details,
    double cardHeight,
    List<Survey> surveys,
    BuildContext context,
  ) {
    if (isAnimating) return;

    if (offsetY < -100 && displayedIndex < surveys.length) {
      // Swipe up validé - animation vers le haut
      final targetY = -(cardHeight + MediaQuery.of(context).padding.top);

      _controller.reset();
      _animation = Tween<double>(begin: offsetY, end: targetY).animate(_controller);
      _othersAnimation = Tween<double>(begin: 0, end: 10).animate(_controller);

      void animationListener() {
        setState(() {
          offsetY = _animation.value;
          othersOffsetY = _othersAnimation.value;
        });
      }

      void statusListener(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          context.read<SurveysBloc>().add(PassSurveyEvent(
                surveyId: surveys[displayedIndex].id,
                shouldBeMarkedAsSkipped: surveys[displayedIndex].displayResults,
                currentIndex: displayedIndex,
              ));
          setState(() {
            displayedIndex++;
            offsetY = 0;
            othersOffsetY = 0;
            isAnimating = false;
          });
          _animation.removeListener(animationListener);
          _controller.removeStatusListener(statusListener);
        }
      }

      _animation.addListener(animationListener);
      _controller.addStatusListener(statusListener);

      isAnimating = true;
      _controller.forward();
    } else if (offsetY > 100 && displayedIndex > 0) {
      // Swipe down validé - animation vers le bas (retour en arrière)
      final currentCardTargetY = cardHeight + MediaQuery.of(context).padding.top;

      _controller.reset();
      _animation = Tween<double>(begin: offsetY, end: currentCardTargetY).animate(_controller);
      _othersAnimation = Tween<double>(begin: 0, end: -10).animate(_controller);

      void animationListener() {
        setState(() {
          offsetY = _animation.value;
          othersOffsetY = _othersAnimation.value;
        });
      }

      void statusListener(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            displayedIndex--;
            offsetY = 0;
            othersOffsetY = 0;
            isAnimating = false;
          });
          _animation.removeListener(animationListener);
          _controller.removeStatusListener(statusListener);
        }
      }

      _animation.addListener(animationListener);
      _controller.addStatusListener(statusListener);

      isAnimating = true;
      _controller.forward();
    } else {
      // Retour à la position initiale
      _controller.reset();
      _animation = Tween<double>(begin: offsetY, end: 0).animate(_controller);

      void animationListener() {
        setState(() {
          offsetY = _animation.value;
        });
      }

      void statusListener(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          isAnimating = false;
          _animation.removeListener(animationListener);
          _controller.removeStatusListener(statusListener);
        }
      }

      _animation.addListener(animationListener);
      _controller.addStatusListener(statusListener);

      isAnimating = true;
      _controller.forward();
    }
  }

  void _onVerticalDragUpdate(DragUpdateDetails details, List<Survey> surveys) {
    if (isAnimating) return;
    setState(() {
      offsetY += details.delta.dy;

      // Sur la fake card, interdire le swipe up
      if (displayedIndex >= surveys.length && offsetY < 0) {
        offsetY = 0;
      }
    });
  }

  bool _isCurrentCard(int localIndex) {
    return localIndex == (displayedIndex > 0 ? 1 : 0);
  }
}
