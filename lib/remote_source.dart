import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class RemoteSource {
  final client = Dio();

  Future<Uint8List> downloadFromUrl(String url, StreamController<double> progressStreamController) async {
    try {
      final result = await client.get<Uint8List>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
        onReceiveProgress: (count, total) {
          print(count);
          print(total);
          final percentage = count / total;
          print('$percentage');
          progressStreamController.add(min(percentage, 1.0));
        },
      );
      return result.data!;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
