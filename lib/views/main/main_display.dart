import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masjid_tv/models/ptime_model.dart';
import 'package:masjid_tv/services/db.dart';
import 'package:masjid_tv/views/main/layouts/portrait.dart';
import 'package:masjid_tv/views/main/layouts/landscape.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: Future.wait([
              DBProvider.db.selectPrayerTime(),
              SharedPreferences.getInstance()
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              return snapshot.hasData
                ? _MainDisplay(pTime: snapshot.data[0], prefs: snapshot.data[1])
                : Container();
            }
          );
        }
      )
    );
  }
}

class _MainDisplay extends StatefulWidget {
  final PTime pTime;
  final SharedPreferences prefs;

  _MainDisplay({
    Key key,
    @required this.pTime,
    @required this.prefs,
  }) : super(key: key);
  
  @override
  _MainDisplayState createState() => _MainDisplayState();
}

class _MainDisplayState extends State<_MainDisplay> {
  List _prayTimes(String prayer, String prayerTime, int iqomahTime) {
    final DateTime _now = DateTime.now();
    final String _date = DateFormat('yyyy-MM-dd').format(_now);
  
    final DateTime _start = DateTime.parse(_date + ' ' + prayerTime);
    final DateTime _endAdzan = _start.add(Duration(minutes: 3));
    final DateTime _endIqomah = _endAdzan.add(Duration(minutes: iqomahTime));
    
    if (_now.isAfter(_start) && _now.isBefore(_endAdzan)) {
      return [prayer, _endAdzan.difference(_now), _endIqomah.difference(_now)];
    }
    else if (_now.isAfter(_endAdzan) && _now.isBefore(_endIqomah)) {
      return [prayer, Duration(), _endIqomah.difference(_now)];
    }
    else return ['', Duration(), Duration()];
  }
  
  @override
  Widget build(BuildContext context) {
    List _subuh = _prayTimes(
      'Subuh',
      widget.pTime.subuh,
      widget.prefs.getInt('iqomah_subuh')
    );
    
    List _dzuhur = _prayTimes(
      'Dzuhur',
      widget.pTime.dzuhur,
      widget.prefs.getInt('iqomah_dzuhur')
    );
    
    List _ashar = _prayTimes(
      '\'Ashar',
      widget.pTime.ashar,
      widget.prefs.getInt('iqomah_ashar')
    );
    
    List _maghrib = _prayTimes(
      'Maghrib',
      widget.pTime.maghrib,
      widget.prefs.getInt('iqomah_maghrib')
    );
    
    List _isya = _prayTimes(
      'Isya',
      widget.pTime.isya,
      widget.prefs.getInt('iqomah_isya')
    );

    String _prayer = _subuh[0] + _dzuhur[0] + _ashar[0] + _maghrib[0] + _isya[0];
    Duration _adzan = _subuh[1] + _dzuhur[1] + _ashar[1] + _maghrib[1] + _isya[1];
    Duration _iqomah = _subuh[2] + _dzuhur[2] + _ashar[2] + _maghrib[2] + _isya[2];
    
    return _adzan.inSeconds > 0
      ? _AdzanTime(prayer: _prayer)
      : _iqomah.inSeconds > 0
      ? _IqomahCountdown(countDown: _iqomah)
      : widget.prefs.getString('layout') == 'Landscape'
      ? Landscape()
      : widget.prefs.getString('layout') == 'Portrait'
      ? Portrait()
      : Container();
  }
}

class _AdzanTime extends StatelessWidget {
  final String prayer;

  _AdzanTime({
    Key key,
    @required this.prayer,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    int _second = int.parse(DateFormat('s').format(DateTime.now()));
    
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 64.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(width: 0, color: Colors.black),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              DateFormat('hh:mm:ss').format(DateTime.now()),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(width: 0, color: Colors.black),
            ),
            child: Center(
              child: _second % 2 == 0
              ? Text(
                'Adzan $prayer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 96.0,
                  fontWeight: FontWeight.bold
                ),
              )
              : Container()
            ),
          ),
        ),
      ],
    );
  }
}

class _IqomahCountdown extends StatelessWidget {
  final Duration countDown;

  _IqomahCountdown({
    Key key,
    @required this.countDown,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 64.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(width: 0, color: Colors.black),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              DateFormat('hh:mm:ss').format(DateTime.now()),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(width: 0, color: Colors.black),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    countDown.inMinutes.remainder(60).toString() + ':' +
                    countDown.inSeconds.remainder(60).toString().padLeft(2, '0'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 128.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'Menuju Iqomah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.0
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
