import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:masjid_tv/models/city_model.dart';
import 'package:masjid_tv/utils/urls.dart';

Future getCityList() async {
  String _server = Url.cities;
  Duration timeOut = Duration(seconds: 10);

  try {
    final _response = await http.get(Uri.parse(_server)).timeout(timeOut);

    return compute(parseCityData, _response.body);
  }
  on TimeoutException {
    throw('Jaringan internet tidak stabil');
  }
}

List<City> parseCityData(String responseBody) {
  final parsed = json.decode(responseBody);
  
  return Cities.fromJson(parsed).data;
}
