import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:masjid_tv/models/schedule_model.dart';
import 'package:masjid_tv/services/db.dart';
import 'package:masjid_tv/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future fetchSchedule() async {
  int _latestMonth = 0;
  final Schedule _latestPrayerTime = await DBProvider.db.selectLatestPrayerTime();

  if (_latestPrayerTime.date != null) {
    List<String> _latestDateStr = _latestPrayerTime.date.split('-');
    _latestMonth = int.parse(_latestDateStr.first);
  }

  final List<int> _months = [for (int i=_latestMonth; i<12; i++) i+1];

  await Future.forEach(_months, (month) async {
    try {
      await fetchingData(month);
    }
    on TimeoutException {
      throw('Jaringan internet tidak stabil');
    }
  });

  return true;
}

Future fetchingData(int month) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  final int _locationId = _prefs.getInt('location_id');
  final String _locationIdStr = _locationId.toString().padLeft(4, '0');

  final String _server = Url.schedule + '/$_locationIdStr/2024/$month';
  final http.Response _response = await http.get(Uri.parse(_server)).timeout(Duration(seconds: 10));
  final Map<String, dynamic> _jsonData = json.decode(_response.body);
  final List<Schedule> schedules = Schedules.fromJson(_locationId, _jsonData).data;
  
  schedules.forEach((schedule) => DBProvider.db.insertPrayerTime(schedule));
}
