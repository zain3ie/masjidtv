import 'dart:io';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Directory> getStorage() async {
  PermissionStatus _status = await Permission.storage.status;
  if (!_status.isGranted) {
    await Permission.storage.request();
  }
  
  final Directory dir = Directory('/storage/emulated/0/masjidtv');
  
  if (!dir.existsSync()) {
    await dir.create(recursive: true);
    await copyAsset('masjidil_haram.jpg');
    await copyAsset('masjid_nabawi.jpg');
    await copyAsset('running_text.txt');
  }
  
  return dir;
}

Future<void> copyAsset(String path) async {
  final ByteData data = await rootBundle.load('assets/$path');
  final List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  await File('sdcard/masjidtv/$path').writeAsBytes(bytes);
}
