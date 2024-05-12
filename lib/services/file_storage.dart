import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationCacheDirectory();
    return directory.path;
  }

  Future<File> _createFile(String name) async {
    final path = await _localPath;
    return File('$path/$name.json').create();
  }

  Future writeFile(String fileName, String content) async {
    final file = await _createFile(fileName);
    // Write the file
    return file.writeAsString(content);
  }

  Future<String> readFile(
      {required String fileName,
      String? content,
      required String format,
      String? customPath}) async {
    try {
      final path = customPath ?? await _localPath;
      final File file = File('$path/$fileName.$format');
      return await file.readAsString();
    } catch (e) {
      return '';
    }
  }

  Future<void> delete(String fileName,
      {required String format, String? customPath}) async {
    final path = customPath ?? await _localPath;
    final File file = File('$path/$fileName.$format');
    file.delete();
  }
}
