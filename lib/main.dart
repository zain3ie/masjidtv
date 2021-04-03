import 'package:flutter/material.dart';
import 'package:masjid_tv/views/main/main_display.dart';

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
      home: MainDisplay(),
    );
  }
}
