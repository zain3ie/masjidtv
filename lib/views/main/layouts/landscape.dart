import 'package:flutter/material.dart';
import 'package:masjid_tv/views/main/components/carousel.dart';
import 'package:masjid_tv/views/main/components/header.dart';
import 'package:masjid_tv/views/main/components/prayer_time.dart';
import 'package:masjid_tv/views/main/components/running_text.dart';

class Landscape extends StatelessWidget {
  final Function() notifyParent;

  Landscape({
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
