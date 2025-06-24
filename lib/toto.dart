import 'package:flutter/material.dart';

class ScrollAndDragContainer extends StatefulWidget {
  const ScrollAndDragContainer({super.key});

  @override
  State<ScrollAndDragContainer> createState() => _ScrollAndDragContainerState();
}

class _ScrollAndDragContainerState extends State<ScrollAndDragContainer> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;
  double? _dragStartY;
  double _offsetY = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final position = _scrollController.position;
    final atBottom = position.pixels >= position.maxScrollExtent;
    if (atBottom != _isAtBottom) {
      setState(() {
        _isAtBottom = atBottom;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    _dragStartY = details.localPosition.dy;
    print('dragStartY: $_dragStartY');
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    print('dragUpdateY: ${details.localPosition.dy}');
    if (_dragStartY == null) return;
    final deltaY = details.localPosition.dy - _dragStartY!;

    if (_isAtBottom && deltaY > 10) {
      // Tu scrolles vers le bas alors que t'es déjà à fond
      print('Déclencher animation parent');
      // ➜ Mets ton animation ici
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      // Pour capter le pointer et le relayer même si l'enfant l’absorbe
      onPointerUp: (event) {
        print('pointerUp');
        setState(() {
          _offsetY = 0;
        });
      },
      onPointerDown: (event) {
        print('pointerDown');
      },
      onPointerCancel: (event) {
        print('pointerCancel');
      },
      onPointerMove: (event) {
        final deltaY = event.localPosition.dy - _scrollController.position.pixels;
        print('deltaY: $deltaY');
        print('distance: ${event.distance}');
        print('_isAtBottom: $_isAtBottom');
        print('event: $event');
        print('pointerMove');
        if (_isAtBottom) {
          setState(() {
            _offsetY = deltaY;
          });
        }
      },
      behavior: HitTestBehavior.translucent,
      child: GestureDetector(
        onVerticalDragStart: _handleDragStart,
        onVerticalDragUpdate: _handleDragUpdate,
        child: Column(
          children: [
            Container(
              height: 400,
              color: Colors.grey[300],
              child: NotificationListener<ScrollNotification>(
                onNotification: (_) => true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(padding: const EdgeInsets.all(16.0), child: Text('Lorem ipsum\n' * 100)),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, _offsetY),
              child: Container(height: 100, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
