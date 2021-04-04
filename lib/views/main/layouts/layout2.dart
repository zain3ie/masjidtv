import 'package:flutter/material.dart';
import 'package:masjid_tv/views/main/components/carousel.dart';
import 'package:masjid_tv/views/main/components/header.dart';
import 'package:masjid_tv/views/main/components/prayer_time.dart';
import 'package:masjid_tv/views/main/components/running_text.dart';

class Layout2 extends StatelessWidget {
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
        RunningText()
      ],
    );
  }
}
