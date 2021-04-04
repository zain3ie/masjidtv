class Cities {
  List<City> data;
  
  Cities({
    this.data
  });
  
  factory Cities.fromJson(Map<String, dynamic> json) {
    var data = json['kota'] as List;
    List<City> dataList = data.map((i) => City.fromJson(i)).toList();
    
    return Cities(data: dataList);
  }
}

class City {
  int id;
  String name;
  
  City({
    this.id,
    this.name
  });
  
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: int.parse(json['id']),
      name: json['nama']
    );
  }
}
