import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/your_file.txt');
  }

  Future<File> writeData(String data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }

  Future<File> createFile(String content) async {
    final file = await _localFile;
    return file.writeAsString(content);
  }

  Future<void> deleteFile() async {
    final file = await _localFile;
    await file.delete();
  }
}
