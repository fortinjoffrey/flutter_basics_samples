import 'package:flutter/material.dart';

class CustomScrollViewReversedPage extends StatefulWidget {
  const CustomScrollViewReversedPage({Key? key}) : super(key: key);

  @override
  State<CustomScrollViewReversedPage> createState() => _CustomScrollViewReversedPageState();
}

class _CustomScrollViewReversedPageState extends State<CustomScrollViewReversedPage> {
  final List<String> _items = List<String>.generate(20, (i) => "Item $i");
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;  // Indicateur pour éviter les appels multiples

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 && !_isLoading) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    setState(() {
      _isLoading = true;  // Début du chargement
    });

    // Simule un délai pour le chargement des nouveaux éléments
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        final newItems = List<String>.generate(10, (i) => "Item ${_items.length + i}");
        _items.addAll(newItems);
        _isLoading = false;  // Fin du chargement
      });
    });
  }

  void _addNewItem(String text) {
    // Capture de la hauteur de la liste avant l'ajout
    final currentScrollPosition = _scrollController.position.pixels;
    final scrollExtent = _scrollController.position.maxScrollExtent;

    setState(() {
      // Ajoute le nouvel élément en haut de la liste pour qu'il apparaisse visuellement en bas
      _items.insert(0, text);
    });

    // // Rétablir la position de défilement
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final newScrollExtent = _scrollController.position.maxScrollExtent;
    //   final difference = newScrollExtent - scrollExtent;
    //   _scrollController.jumpTo(currentScrollPosition + difference);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto scroll'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                reverse: true,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          title: Text(_items[index]),
                        );
                      },
                      childCount: _items.length,
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your text here',
              ),
              onSubmitted: (text) {
                _addNewItem(text);  // Ajoute un nouvel élément
              },
            ),
          ],
        ),
      ),
    );
  }
}
