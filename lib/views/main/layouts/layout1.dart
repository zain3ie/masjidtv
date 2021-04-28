import 'package:flutter/material.dart';
import 'package:masjid_tv/views/main/components/carousel.dart';
import 'package:masjid_tv/views/main/components/header.dart';
import 'package:masjid_tv/views/main/components/prayer_time.dart';
import 'package:masjid_tv/views/main/components/running_text.dart';

class Layout1 extends StatefulWidget {
  @override
  _Layout1State createState() => _Layout1State();
}

class _Layout1State extends State<Layout1> {
  refresh() => setState(() {});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header(),
        Expanded(
          child: Carousel(),
        ),
        PrayerTime(layout: 'row'),
        RunningText(notifyParent: refresh)
      ],
    );
  }
}
