class PrayerTime {
  String imsak;
  String subuh;
  String terbit;
  String dhuha;
  String dzuhur;
  String ashar;
  String maghrib;
  String isya;

  PrayerTime({
    this.imsak,
    this.subuh,
    this.terbit,
    this.dhuha,
    this.dzuhur,
    this.ashar,
    this.maghrib,
    this.isya,
  });
  
  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    return PrayerTime(
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
}
