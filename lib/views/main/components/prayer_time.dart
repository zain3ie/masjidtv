import 'package:flutter/material.dart';
import 'package:masjid_tv/models/schedule_model.dart';
import 'package:masjid_tv/services/db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(width: 0, color: Colors.black),
      ),
      child: FutureBuilder(
        future: DBProvider.db.selectPrayerTime(),
        builder: (context, snapshot) {
          return snapshot.hasData
            ? PrayersTimeWidget(schedule: snapshot.data)
            : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PrayersTimeWidget extends StatelessWidget {
  final Schedule schedule;

  PrayersTimeWidget({
    Key key,
    @required this.schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _prayerTimeWidgets = [
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Imsak',
          time: schedule.imsak ?? '',
          color: Colors.indigoAccent
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Subuh',
          time: schedule.subuh ?? '',
          color: Colors.blueAccent
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Dzuhur',
          time: schedule.dzuhur ?? '',
          color: Colors.yellow[700]
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: '\'Ashar',
          time: schedule.ashar ?? '',
          color: Colors.orangeAccent
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Maghrib',
          time: schedule.maghrib ?? '',
          color: Colors.redAccent
        ),
      ),
      SizedBox(width: 16.0, height: 8.0),
      Expanded(
        child: _PrayerTimeWidget(
          title: 'Isya',
          time: schedule.isya ?? '',
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
