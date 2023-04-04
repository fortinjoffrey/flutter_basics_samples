import 'package:flutter/material.dart' show Color;

// Must be #XXXXXX or XXXXXX
Color getColorfromHexString(String hexString) {
  final buffer = StringBuffer('FF');

  if (hexString.length < 6 || hexString.length > 7) {
    throw Exception('invalid hex format, use #XXXXXX or XXXXXX format');
  }

  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
