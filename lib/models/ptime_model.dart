import 'package:intl/intl.dart';

class PTime {
  String date;
  String imsak;
  String subuh;
  String terbit;
  String dhuha;
  String dzuhur;
  String ashar;
  String maghrib;
  String isya;

  PTime({
    this.date,
    this.imsak,
    this.subuh,
    this.terbit,
    this.dhuha,
    this.dzuhur,
    this.ashar,
    this.maghrib,
    this.isya,
  });
  
  factory PTime.fromJson(Map<String, dynamic> json) {
    return PTime(
      date: DateFormat('MM-dd').format(DateTime.parse(json['query']['tanggal'])),
      imsak: json['jadwal']['data']['imsak'],
      subuh: json['jadwal']['data']['subuh'],
      terbit: json['jadwal']['data']['terbit'],
      dhuha: json['jadwal']['data']['dhuha'],
      dzuhur: json['jadwal']['data']['dzuhur'],
      ashar: json['jadwal']['data']['ashar'],
      maghrib: json['jadwal']['data']['maghrib'],
      isya: json['jadwal']['data']['isya'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'imsak': imsak,
      'subuh': subuh,
      'terbit': terbit,
      'dhuha': dhuha,
      'dzuhur': dzuhur,
      'ashar': ashar,
      'maghrib': maghrib,
      'isya': isya,
    };
  }

  PTime.fromMap(Map<String, dynamic> map) {
    date = map['date'];
    imsak = map['imsak'];
    subuh = map['subuh'];
    terbit = map['terbit'];
    dhuha = map['dhuha'];
    dzuhur = map['dzuhur'];
    ashar = map['ashar'];
    maghrib = map['maghrib'];
    isya = map['isya'];
  }
}
