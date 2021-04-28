import 'package:flutter/material.dart';
import 'package:masjid_tv/views/main/components/carousel.dart';
import 'package:masjid_tv/views/main/components/header.dart';
import 'package:masjid_tv/views/main/components/prayer_time.dart';
import 'package:masjid_tv/views/main/components/running_text.dart';

class Portrait extends StatelessWidget {
  final Function() notifyParent;

  Portrait({
    Key key,
    @required this.notifyParent
  }) : super(key: key);
  
  refresh() => notifyParent();
  
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
