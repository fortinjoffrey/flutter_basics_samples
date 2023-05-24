import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

abstract class FileUtils {
  static Future<File> createFileFromUrl(String url) async {
    final Uri? uri = Uri.tryParse(url);

    if (null == uri) return File('');

    final String filename = _filenameFromUrl(url);
    final Directory? directory = await _getDirectory();

    if (directory == null) return File('');
    final String path = '${directory.path}/$filename';

    final File file = File(path);

    if (file.existsSync()) return file;

    try {
      await Dio().downloadUri(uri, path);
      return file;
    } catch (e) {
      return File('');
    }
  }

  static Future<Directory?> _getDirectory() async {
    return await getTemporaryDirectory();
  }

  static String _filenameFromUrl(String url) {
    return url.substring(url.lastIndexOf("/") + 1);
  }
}
