import 'dart:convert';

import 'package:flutter/services.dart';

class FakeDataSource {
  Future<String> getHtmlData() async {
    await Future<void>.delayed(const Duration(seconds: 2)); // fake timer
    final String response = await rootBundle.loadString('assets/dummy_html.json');
    final dynamic data = await json.decode(response);
    final String flux = data['data4'] as String;
    print(flux);
    return flux;
    ;
  }
}
