import 'package:flutter/material.dart';
import 'package:masjid_tv/utils/routers.dart';
import 'package:masjid_tv/views/main/main_display.dart';
import 'package:masjid_tv/views/settings/iqomah.dart';
import 'package:masjid_tv/views/settings/layout.dart';
import 'package:masjid_tv/views/settings/location.dart';
import 'package:masjid_tv/views/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masjid TV',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder(
        future: _setInitialPreferences(),
        builder: (context, snapshot) {
          return SettingsView();
        }
      ),
      routes: <String, WidgetBuilder>{
        MyRouter.main : (BuildContext context) => MainDisplay(),
        MyRouter.setting : (BuildContext context) => SettingsView(),
        MyRouter.layoutSetting : (BuildContext context) => LayoutSetting(),
        MyRouter.locationSetting : (BuildContext context) => LocationSetting(),
        MyRouter.iqomahSetting : (BuildContext context) => IqomahSetting(),
      }
    );
  }
}

Future _setInitialPreferences() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();

  if (!_prefs.containsKey('masjid_name')) {
    _prefs.setString('masjid_name', '');
    _prefs.setString('layout', 'Landscape');
    _prefs.setString('location', '');
    _prefs.setInt('location_id', 0);
    _prefs.setInt('iqomah_subuh', 5);
    _prefs.setInt('iqomah_dzuhur', 5);
    _prefs.setInt('iqomah_ashar', 5);
    _prefs.setInt('iqomah_maghrib', 5);
    _prefs.setInt('iqomah_isya', 5);
  }
}
