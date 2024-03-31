import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationCacheDirectory();
    // print(directory.absolute);
    return directory.path;
  }

  Future<File> _createFile(String name) async {
    final path = await _localPath;
    return File('$path/$name.json').create(recursive: true, exclusive: false);
  }

  Future writeFile(String fileName, String? content) async {
    final file = await _createFile(fileName);
    // Write the file
    return file.writeAsString(content??'');
  }

  Future<String> readFile({required String fileName, String? content}) async {

    final File file = File('$_localPath/$fileName.json');
    return await file.readAsString();


  }
}
