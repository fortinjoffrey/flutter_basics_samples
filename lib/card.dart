import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  const MyCard({
    super.key,
    required this.backgroundColor,
    required this.question,
    required this.swipeable,
    required this.onSwipeUp,
    required this.onSwipeDown,
  });

  final Color backgroundColor;
  final String question;
  final bool swipeable;
  final VoidCallback onSwipeUp;
  final VoidCallback onSwipeDown;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> with TickerProviderStateMixin {
  final ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);
  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _positionAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.addListener(() {
      setState(() {
        _offset.value = _positionAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (!widget.swipeable) return;

    setState(() {
      _offset.value += details.delta;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    // Vérifier la vélocité (vitesse de défilement)
    final double velocity = details.primaryVelocity ?? 0;
    final double velocityThreshold = 1000; // Seuil de vélocité en pixels/seconde

    // Vérifier la distance parcourue
    final double distance = _offset.value.dy.abs();
    final double distanceThreshold = 300; // Seuil de distance en pixels

    // Vérifier la direction et la vélocité
    if (velocity > 0 && velocity > velocityThreshold) {
      print("Should swipe down");
      _swipeDown();
      return;
    } else if (velocity < 0 && velocity.abs() > velocityThreshold) {
      print("Should swipe up");
      _swipeUp();
      return;
    }

    // Vérifier la direction et la distance
    if (_offset.value.dy > 0 && distance > distanceThreshold) {
      print("Should swipe down");
      _swipeDown();
      return;
    } else if (_offset.value.dy < 0 && distance > distanceThreshold) {
      print("Should swipe up");
      _swipeUp();
      return;
    }

    // Si la vélocité est insuffisante OU si la distance est insuffisante
    if (velocity.abs() < velocityThreshold || distance < distanceThreshold) {
      _resetPosition();
    }
  }

  void _swipeUp() {
    print("swiping up");
    // _animateCardToPosition(Offset(0, -MediaQuery.of(context).size.height));
    widget.onSwipeUp();
  }

  void _swipeDown() {
    print("swiping down");
    // _animateCardToPosition(Offset(0, MediaQuery.of(context).size.height));
    widget.onSwipeDown();
  }

  void _resetPosition() {
    print("resetting position");
    _animateCardToPosition(Offset.zero);
  }

  Future<void> _animateCardToPosition(Offset position) async {
    _positionAnimation = Tween<Offset>(begin: _offset.value, end: position).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.reset();
    await _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      onTap: () {
        print('tapped swipeable: ${widget.swipeable}');
      },
      child: AnimatedBuilder(
        animation: _offset,
        builder: (context, child) {
          return Transform.translate(
            offset: _offset.value,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Center(child: Text(widget.question)),
        ),
      ),
    );
  }
}
