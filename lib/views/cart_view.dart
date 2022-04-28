import 'dart:collection';

import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headline1),
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Consumer<CartModel>(
                  builder: (context, cartModel, child) {
                    return _buildCartItemsList(cartModel.items);
                  },
                ),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            ElevatedButton(
                onPressed: () {
                  context.read<CartModel>().clearItems();
                },
                child: Text('Remove all items')),
            Divider(height: 4, color: Colors.black),
            _buildCartTotal(context),
            // _CartTotal()
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemsList(UnmodifiableListView<Item> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => _CartItemTile(item: items[index]),
    );
  }

  Widget _buildCartTotal(BuildContext context) {
    var hugeStyle = Theme.of(context).textTheme.headline1!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
              builder: (context, cart, child) {
                return Text('\$${cart.totalPrice}', style: hugeStyle);
              },
            ),
            SizedBox(width: 24),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Buying not supported yet.')));
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Remove this item?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<CartModel>().remove(item);
                      Navigator.of(context).pop();
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            });
      },
      leading: Icon(Icons.done),
      title: Text(
        item.name,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
