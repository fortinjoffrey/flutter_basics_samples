import 'dart:io';

abstract class JsonUtils {
  static String fromFile(String filename) {
    final res = File('test/json/$filename').readAsStringSync();
    print(res);
    return res;
  }
}
