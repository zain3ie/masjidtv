import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:masjid_tv/services/text_service.dart';

class RunningText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: double.infinity,
      color: Colors.black,
      child: FutureBuilder<List<String>>(
        future: getRunningText(),
        builder: (context, snapshot) {
          return snapshot.hasData
            ? Marquee(
              text: snapshot.data.join(' ● ') + ' ● ',
              style: TextStyle(color: Colors.white),
            )
            : Container();
        }
      ),
    );
  }
}
