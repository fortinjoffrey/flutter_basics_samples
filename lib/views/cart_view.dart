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
        backgroundColor: Colors.white,
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
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        title: Text(
          items[index].name,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
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
