import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:masjid_tv/models/prayer_time_model.dart';
import 'package:masjid_tv/services/db.dart';
import 'package:masjid_tv/utils/urls.dart';

Future getPrayerTime() async {
  String _server;
  http.Response _response;
  Map<String, dynamic> _jsonData;
  PrayerTime prayerTime;
  
  Duration _timeOut = Duration(seconds: 10);
  DateTime _date = DateTime(2020, 1, 1);

  while (_date != DateTime(2021, 1, 1)) {
    try {
      _server = Url.schedule + '/kota/622/tanggal/' + DateFormat('yyyy-MM-dd').format(_date);
      _response = await http.get(Uri.parse(_server)).timeout(_timeOut);
      _jsonData = json.decode(_response.body);
      prayerTime = PrayerTime.fromJson(_jsonData);
      await DBProvider.db.insertPrayerTime(prayerTime);
    }
    on TimeoutException {
      throw('Jaringan internet tidak stabil');
    }

    _date = _date.add(Duration(days: 1));
  }

  return prayerTime;
}
