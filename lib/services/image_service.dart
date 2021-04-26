import 'dart:io';

import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';

Future getImage() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }

  final Directory dir = Directory('sdcard/masjidtv');
  final List<FileSystemEntity> files = await dir.list().toList();
  List<FileSystemEntity> imageFiles = <FileSystemEntity>[];

  files.forEach((file) {
    String mimeStr = lookupMimeType(file.path);
    List<String> fileTypes = mimeStr.split('/');
    
    if (fileTypes[0] == 'image') {
      imageFiles.add(file);
    }
  });
  
  return imageFiles;
}
