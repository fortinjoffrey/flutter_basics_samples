// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/cart_view.dart';
import 'views/catalog_view.dart';

import 'models/cart_model.dart';
import 'views/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        title: 'Provider Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontFamily: 'Corben',
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginView(),
          '/catalog': (context) => CatalogView(),
          '/cart': (context) => CartView(),
        },
      ),
    );
  }
}
