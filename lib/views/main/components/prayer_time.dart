import 'package:flutter/material.dart';
import 'package:masjid_tv/models/ptime_model.dart';
import 'package:masjid_tv/services/db.dart';

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
      padding: EdgeInsets.all(8.0),
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
    return Column(
      children: [
        Expanded(
          child: PrayerTimeWidget(
            layout: 'column',
            title: 'Imsak',
            time: pTime.imsak ?? '',
            color: Colors.indigoAccent
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: PrayerTimeWidget(
            layout: 'column',
            title: 'Subuh',
            time: pTime.subuh ?? '',
            color: Colors.blueAccent
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: PrayerTimeWidget(
            layout: 'column',
            title: 'Dzuhur',
            time: pTime.dzuhur ?? '',
            color: Colors.yellow[700]
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: PrayerTimeWidget(
            layout: 'column',
            title: '\'Ashar',
            time: pTime.ashar ?? '',
            color: Colors.orangeAccent
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: PrayerTimeWidget(
            layout: 'column',
            title: 'Maghrib',
            time: pTime.maghrib ?? '',
            color: Colors.redAccent
          ),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: PrayerTimeWidget(
            layout: 'column',
            title: 'Isya',
            time: pTime.isya ?? '',
            color: Colors.purpleAccent
          ),
        ),
      ],
    );
  }
}

class PrayerTimeWidget extends StatelessWidget {
  final String layout;
  final String title;
  final String time;
  final Color color;

  PrayerTimeWidget({
    Key key,
    @required this.layout,
    @required this.title,
    @required this.time,
    @required this.color
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
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
