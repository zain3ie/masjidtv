import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future getRunningText() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }

  final File textFile = File('sdcard/masjidtv/running_text.txt');
  final List<String> text = await textFile.readAsLines().then((text) => text);
  
  return text;
}
