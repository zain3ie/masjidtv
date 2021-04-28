import 'package:flutter/material.dart';
import 'package:masjid_tv/views/main/components/carousel.dart';
import 'package:masjid_tv/views/main/components/header.dart';
import 'package:masjid_tv/views/main/components/prayer_time.dart';
import 'package:masjid_tv/views/main/components/running_text.dart';

class Layout2 extends StatefulWidget {
  @override
  _Layout2State createState() => _Layout2State();
}

class _Layout2State extends State<Layout2> {
  refresh() => setState(() {});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header(),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Carousel()
              ),
              PrayerTime(layout: 'column'),
            ],
          ),
        ),
        RunningText(notifyParent: refresh)
      ],
    );
  }
}
