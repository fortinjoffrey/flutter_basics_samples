import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../models/item.dart';
import 'package:provider/provider.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({Key? key}) : super(key: key);

  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: itemNames.length,
        itemBuilder: (context, index) {
          return _MyListItem(index, itemNames[index]);
        },
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  final String name;

  _MyListItem(this.index, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = Item(index, name);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: Theme.of(context).textTheme.headline6),
            ),
            SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        var cart = context.read<CartModel>();
        cart.add(item);
      },
      child: Text('ADD'),
    );
  }
}
