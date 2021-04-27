import 'dart:io';

import 'package:masjid_tv/services/storage_service.dart';
import 'package:mime/mime.dart';

Future<List<FileSystemEntity>> getImage() async {
  final Directory _dir = await getStorage();
  final List<FileSystemEntity> _files = await _dir.list().toList();
  List<FileSystemEntity> imageFiles = <FileSystemEntity>[];

  _files.forEach((file) {
    String _mimeStr = lookupMimeType(file.path);
    List<String> _fileTypes = _mimeStr.split('/');
    
    if (_fileTypes.first == 'image') imageFiles.add(file);
  });
  
  return imageFiles;
}
