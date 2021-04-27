import 'dart:io';

import 'package:masjid_tv/services/storage_service.dart';

Future<List<String>> getRunningText() async {
  final Directory _dir = await getStorage();
  final String _dirPath = _dir.path;
  final File _textFile = File('$_dirPath/running_text.txt');
  final List<String> text = await _textFile.readAsLines();
  
  return text;
}
