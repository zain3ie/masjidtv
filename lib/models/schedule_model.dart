import 'package:intl/intl.dart';

class Schedules {
  final List<Schedule> data;

  Schedules({
    this.data
  });
  
  factory Schedules.fromJson(int locationId, Map<String, dynamic> json) {
    var data = json['data']['jadwal'] as List;
    List<Schedule> dataList = data.map((i) => Schedule.fromJson(locationId, i)).toList();

    return Schedules(data: dataList);
  }
}

class Schedule {
  int locationId;
  String date;
  String imsak;
  String subuh;
  String terbit;
  String dhuha;
  String dzuhur;
  String ashar;
  String maghrib;
  String isya;

  Schedule({
    this.locationId,
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
  
  factory Schedule.fromJson(int locationId, Map<String, dynamic> json) {
    return Schedule(
      locationId: locationId,
      date: DateFormat('MM-dd').format(DateTime.parse(json['date'])),
      imsak: json['imsak'],
      subuh: json['subuh'],
      terbit: json['terbit'],
      dhuha: json['dhuha'],
      dzuhur: json['dzuhur'],
      ashar: json['ashar'],
      maghrib: json['maghrib'],
      isya: json['isya'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'location_id': locationId,
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

  Schedule.fromMap(Map<String, dynamic> map) {
    locationId = map['location_id'];
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
