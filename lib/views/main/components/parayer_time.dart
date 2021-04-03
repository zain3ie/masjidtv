import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          Expanded(
            child: PrayerTimeWidget(
              layout: 'column',
              title: 'Imsak',
              time: '04:39',
              color: Colors.indigoAccent
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: PrayerTimeWidget(
              layout: 'column',
              title: 'Subuh',
              time: '04:49',
              color: Colors.blueAccent
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: PrayerTimeWidget(
              layout: 'column',
              title: 'Dzuhur',
              time: '12:08',
              color: Colors.yellow[700]
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: PrayerTimeWidget(
              layout: 'column',
              title: '\'Ashar',
              time: '15:18',
              color: Colors.orangeAccent
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: PrayerTimeWidget(
              layout: 'column',
              title: 'Magrib',
              time: '16:12',
              color: Colors.redAccent
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: PrayerTimeWidget(
              layout: 'column',
              title: 'Isya',
              time: '19:00',
              color: Colors.purpleAccent
            ),
          )
        ],
      ),
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