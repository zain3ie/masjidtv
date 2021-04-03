import 'package:hijri/hijri_calendar.dart';

const Map<int, String> _month = {
  1: 'Muharram',
  2: 'Safar',
  3: 'Rabi\'ul Awal',
  4: 'Rabi\'ul Akhir',
  5: 'Jumadil Awal',
  6: 'Jumadil Akhir',
  7: 'Rajab',
  8: 'Sya\'ban',
  9: 'Ramadan',
  10: 'Syawal',
  11: 'Dzulkaidah',
  12: 'Dzulhijjah'
};

String hijriyahDate() {
  HijriCalendar _today = new HijriCalendar.now();
  List _date = [
    _today.hDay.toString(),
    _month[_today.hMonth],
    _today.hYear.toString()
  ];
  
  return _date.join(' ');
}