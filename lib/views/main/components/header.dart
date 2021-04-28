import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:masjid_tv/utils/hijriyah.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.0),
      color: Colors.black,
      child: Row(
        children: [
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              return Container(
                child: Column(
                  children: [
                    Text(
                      DateFormat('EEEE', 'ID_id').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      DateFormat('d MMMM yyyy', 'ID_id').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      hijriyahDate(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
          
          Expanded(
            child: Container(
              child: Center(
                child: FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.hasData
                        ? snapshot.data.getString('masjid_name')
                        : '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.white
                      ),
                    );
                  }
                ),
              ),
            ),
          ),
          
          Container(
            child: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Text(
                  DateFormat('hh:mm:ss').format(DateTime.now()),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
