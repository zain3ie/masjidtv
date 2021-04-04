import 'package:flutter/material.dart';
import 'package:masjid_tv/views/main/main_display.dart';
import 'package:masjid_tv/views/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masjid TV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Settings(),
    );
  }
}
