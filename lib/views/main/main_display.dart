import 'package:flutter/material.dart';
import 'package:masjid_tv/views/main/layouts/portrait.dart';
import 'package:masjid_tv/views/main/layouts/landscape.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDisplay extends StatefulWidget {
  @override
  _MainDisplayState createState() => _MainDisplayState();
}

class _MainDisplayState extends State<MainDisplay> {
  refresh() => setState(() {});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          return snapshot.hasData
            ? snapshot.data.getString('layout') == 'Landscape'
            ? Landscape(notifyParent: refresh)
            : snapshot.data.getString('layout') == 'Portrait'
            ? Portrait(notifyParent: refresh)
            : Container()
            : Container();
        }
      )
    );
  }
}
