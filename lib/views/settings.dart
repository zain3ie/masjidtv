import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masjid_tv/models/city_model.dart';
import 'package:masjid_tv/models/prayer_time_model.dart';
import 'package:masjid_tv/services/city_service.dart';
import 'package:masjid_tv/services/prayer_time_service.dart';
import 'package:sqflite/sqflite.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<DateTime> dateList = List<DateTime>.generate(
      366, (i) => DateTime(2020, 1, 1).add(Duration(days: i))
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        // child: ListView.builder(
        //   itemCount: dateList.length,
        //   itemBuilder: (context, index) {
        //     return Text(DateFormat('yyyy-MM-dd').format(dateList[index]));
        //   }
        // )
        // child: FutureBuilder(
        //   future: getCityList(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) print(snapshot.error);
        //
        //     return snapshot.hasData
        //       ? ListView.builder(
        //         itemCount: snapshot.data.length,
        //         itemBuilder: (context, index) {
        //           City city = snapshot.data[index];
        //
        //           return Text(city.name);
        //         }
        //       )
        //       : Center(child: CircularProgressIndicator());
        //   }
        // ),
        child: FutureBuilder(
          future: getPrayerTime(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            if (snapshot.hasData) {
              PrayerTime prayerTime = snapshot.data;

              return Column(
                children: [
                  Text(prayerTime.date),
                  Text(prayerTime.ashar),
                  Text(prayerTime.dhuha),
                  Text(prayerTime.dzuhur),
                  Text(prayerTime.imsak),
                  Text(prayerTime.isya),
                  Text(prayerTime.maghrib),
                  Text(prayerTime.subuh),
                  Text(prayerTime.terbit),
                ],
              );
            }
            else {
              return Center(child: CircularProgressIndicator());
            }
          }
        ),
      )
    );
  }
}
