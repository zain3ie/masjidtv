class Locations {
  final List<Location> data;
  
  Locations({
    this.data
  });
  
  factory Locations.fromJson(List<dynamic> json) {
    List<Location> dataList = json.map((i) => Location.fromJson(i)).toList();
    
    return Locations(data: dataList);
  }
}

class Location {
  final int id;
  final String name;
  
  Location({
    this.id,
    this.name
  });
  
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: int.parse(json['id']),
      name: json['lokasi']
    );
  }
}
