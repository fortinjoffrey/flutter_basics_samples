import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

Future<File> saveImageFromUrlToFile(String url) async {
  final uri = Uri.parse(url);

  final Response data = await get(uri);

  final bytes = data.bodyBytes;
  final dir = await getApplicationDocumentsDirectory();

  final File file = File("${dir.path}/image.png");

  await file.writeAsBytes(bytes);
  return file;
}
