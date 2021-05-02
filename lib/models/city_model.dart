class Cities {
  final List<City> data;
  
  Cities({
    this.data
  });
  
  factory Cities.fromJson(List<dynamic> json) {
    List<City> dataList = json.map((i) => City.fromJson(i)).toList();
    
    return Cities(data: dataList);
  }
}

class City {
  final int id;
  final String name;
  
  City({
    this.id,
    this.name
  });
  
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: int.parse(json['id']),
      name: json['lokasi']
    );
  }
}
