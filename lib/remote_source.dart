import 'dart:typed_data';

import 'package:dio/dio.dart';

class RemoteSource {
  final client = Dio();

  Future<Uint8List> downloadFromUrl(String url) async {
    try {
      final result = await client.get<Uint8List>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      return result.data!;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
