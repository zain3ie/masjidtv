import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:masjid_tv/models/location_model.dart';
import 'package:masjid_tv/utils/urls.dart';

Future<List<Location>> getLocationList() async {
  String _server = Url.locations;
  Duration _timeOut = Duration(seconds: 10);
  
  try {
    final _response = await http.get(Uri.parse(_server)).timeout(_timeOut);

    return compute(parseLocationData, _response.body);
  }
  on TimeoutException {
    throw('Jaringan internet tidak stabil');
  }
}

List<Location> parseLocationData(String responseBody) {
  final _jsonResponse = json.decode(responseBody);
  return Locations.fromJson(_jsonResponse).data;
}
