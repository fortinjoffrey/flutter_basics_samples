import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: const CardGrid(),
      ),
    );
  }
}

class CardGrid extends StatelessWidget {
  const CardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return CardWidget(
            text: card["text"],
            color: card["color"],
          );
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String text;
  final Color color;

  const CardWidget({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Exemples de cartes avec tailles dynamiques
final List<Map<String, dynamic>> cards = [
  {"text": "1 Esse Lorem aliquip sit non ad ullamco reprehenderit tempor id ullamco mollit.", "color": Colors.green},
  {"text": "2 Anim in officia nisi veniam aute incididunt magna ut. sqldfkjqldffjql fhql h", "color": Colors.pink},
  {"text": "3 Amet aliqua aliquip aliqua aliqua.", "color": Colors.blue},
  {"text": "4 Duis eiusmod consequat qui consectetur laborum exercitation irure reprehenderit ex fugiat.", "color": Colors.orange},
  {"text": "5 Adipisicing cillum enim voluptate dolore Lorem aliqua laborum eiusmod.", "color": Colors.green},
  {"text": "6 Ea sunt laborum pariatur aute cillum eiusmod sint", "color": Colors.pink},
  {"text": "7 Amet aliqua aliquip", "color": Colors.blue},
  {"text": "8 Exercitation sunt irure Lore", "color": Colors.orange},
  {"text": "9 Cupidatat sunt in proident eu cillum.", "color": Colors.green},
  {"text": "10 Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", "color": Colors.pink},
  {"text": "11 Amet aliqua aliquip", "color": Colors.blue},
  {"text": "12 Une question très courte ?", "color": Colors.orange},
  {"text": "13 Cette question est un peu plus longue et permet de tester l'affichage sur plusieurs lignes.", "color": Colors.green},
  {"text": "14 Test", "color": Colors.pink},
  {"text": "15 Pensez-vous que les nouvelles technologies ont un impact positif sur notre société moderne et notre façon de vivre au quotidien ?", "color": Colors.blue},
  {"text": "16 Question moyenne sur un sujet quelconque ?", "color": Colors.orange},
  {"text": "17 A", "color": Colors.green},
  {"text": "18 Les changements climatiques représentent-ils selon vous une menace immédiate ?", "color": Colors.pink},
  {"text": "19 B C D", "color": Colors.blue},
  {"text": "20 Cette dernière question permet de tester l'affichage avec un texte de longueur intermédiaire.", "color": Colors.orange},
];
