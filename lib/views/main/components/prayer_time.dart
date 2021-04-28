import 'package:flutter/material.dart';
import 'package:masjid_tv/models/ptime_model.dart';
import 'package:masjid_tv/services/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTime extends StatelessWidget {
  final String layout;
  
  PrayerTime({
    Key key,
    @required this.layout
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: FutureBuilder(
        future: DBProvider.db.selectPrayerTime(),
        builder: (context, snapshot) {
          return snapshot.hasData
            ? PrayersTimeWidget(pTime: snapshot.data)
            : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PrayersTimeWidget extends StatelessWidget {
  final PTime pTime;

  PrayersTimeWidget({
    Key key,
    @required this.pTime
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _prayerTimeWidgets = [
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Imsak',
          time: pTime.imsak ?? '',
          color: Colors.indigoAccent
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Subuh',
          time: pTime.subuh ?? '',
          color: Colors.blueAccent
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Dzuhur',
          time: pTime.dzuhur ?? '',
          color: Colors.yellow[700]
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: '\'Ashar',
          time: pTime.ashar ?? '',
          color: Colors.orangeAccent
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Maghrib',
          time: pTime.maghrib ?? '',
          color: Colors.redAccent
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Isya',
          time: pTime.isya ?? '',
          color: Colors.purpleAccent
        ),
      ),
    ];
    
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        return snapshot.hasData
          ? snapshot.data.getString('layout') == 'Landscape'
          ? Column(children: _prayerTimeWidgets)
          : snapshot.data.getString('layout') == 'Portrait'
          ? Row(children: _prayerTimeWidgets)
          : Container()
          : Container();
      }
    );
  }
}

class _PrayerTimeWidget extends StatelessWidget {
  final String title;
  final String time;
  final Color color;

  _PrayerTimeWidget({
    Key key,
    @required this.title,
    @required this.time,
    @required this.color
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
        ],
      ),
    );
  }
}
