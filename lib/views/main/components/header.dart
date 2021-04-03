import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:masjid_tv/utils/hijriyah.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);

    return Container(
      width: double.infinity,
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
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      DateFormat('d MMMM yyyy', 'ID_id').format(DateTime.now()),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      hijriyahDate(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            }
          ),
          
          Expanded(
            child: Container(
              child: Center(
                child: Text(
                  'Masjid Al-Aqobah',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white
                  ),
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
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
