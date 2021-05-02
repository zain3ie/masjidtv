import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masjid_tv/utils/routers.dart';
import 'package:masjid_tv/views/main/main_display.dart';
import 'package:masjid_tv/views/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent()
      },
      child: MaterialApp(
        title: 'Masjid TV',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: FutureBuilder(
          future: _checkPreferences(),
          builder: (context, snapshot) {
            return snapshot.hasData
              ? snapshot.data
              ? MainDisplay()
              : SettingsView()
              : Container();
          }
        ),
        routes: MyRouter.routes
      ),
    );
  }
}

Future _checkPreferences() async {
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
    
    return false;
  }
  
  return true;
}
