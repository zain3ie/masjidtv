import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:masjid_tv/models/ptime_model.dart';
import 'package:masjid_tv/services/db.dart';
import 'package:masjid_tv/utils/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future fetchingPrayerTime() async {
  DateTime _date;
  
  final PTime _latestPrayerTime = await DBProvider.db.selectLatestPrayerTime();

  if (_latestPrayerTime.date == null) {
    _date = DateTime(2019, 12, 31);
  }
  else {
    List<String> _latestDateStr = _latestPrayerTime.date.split('-');
    List<int> _latestDateInt = _latestDateStr.map((date) => int.parse(date)).toList();
    DateTime _latestDate = DateTime(2020, _latestDateInt[0], _latestDateInt[1]);
    _date = _latestDate.add(Duration(days: 1));
  }
  
  while (_date != DateTime(2020, 1, 10)) {
    try {
      await fetchingData(_date);
    }
    on TimeoutException {
      throw('Jaringan internet tidak stabil');
    }

    _date = _date.add(Duration(days: 1));
  }

  return true;
}

Future fetchingData(DateTime date) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  final int _locationId = _prefs.getInt('location_id');

  final String _dateStr = DateFormat('yyyy-MM-dd').format(date);
  final String _server = Url.schedule + '/kota/$_locationId/tanggal/$_dateStr';
  final http.Response _response = await http.get(Uri.parse(_server)).timeout(Duration(seconds: 10));
  final Map<String, dynamic> _jsonData = json.decode(_response.body);
  print(_server);

  final PTime pTime = PTime.fromJson(_locationId, _jsonData);
  
  await DBProvider.db.insertPrayerTime(pTime);
}
