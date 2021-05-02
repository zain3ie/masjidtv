import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:masjid_tv/services/text_service.dart';
import 'package:masjid_tv/utils/routers.dart';

class RunningText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(width: 0, color: Colors.black),
      ),
      child: FutureBuilder<List<String>>(
        future: getRunningText(),
        builder: (context, snapshot) {
          return snapshot.hasData
            ? Row(
              children: [
                Expanded(
                  child: Marquee(
                    text: snapshot.data.join(' ● ') + ' ● ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.settings),
                  color: Colors.white,
                  iconSize: 18.0,
                  onPressed: () {
                    Navigator.of(context).pushNamed(MyRouter.setting);
                  },
                )
              ],
            )
            : Container();
        }
      ),
    );
  }
}
