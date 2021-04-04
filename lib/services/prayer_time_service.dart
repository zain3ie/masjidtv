import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:masjid_tv/models/prayer_time_model.dart';
import 'package:masjid_tv/utils/urls.dart';

Future getPrayerTime() async {
  String _server = Url.schedule + '/kota/622/tanggal/2022-04-03';
  Duration timeOut = Duration(seconds: 10);

  try {
    final _response = await http.get(Uri.parse(_server)).timeout(timeOut);

    return compute(parseCityData, _response.body);
  }
  on TimeoutException {
    throw('Jaringan internet tidak stabil');
  }
}

PrayerTime parseCityData(String responseBody) {
  final parsed = json.decode(responseBody);
  
  return PrayerTime.fromJson(parsed);
}
