import 'package:flutter/material.dart';
import 'package:masjid_tv/models/city_model.dart';
import 'package:masjid_tv/services/city_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Future.wait([getCityList(), SharedPreferences.getInstance()]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error)
              );
            }
  
            return snapshot.hasData
              ? _CityList(cities: snapshot.data[0], prefs: snapshot.data[1])
              : Center(child: CircularProgressIndicator());
          }
        )
      )
    );
  }
}

class _CityList extends StatefulWidget {
  final List<City> cities;
  final SharedPreferences prefs;
  
  _CityList({
    Key key,
    @required this.cities,
    @required this.prefs
  }) : super(key: key);
  
  @override
  _CityListState createState() => _CityListState();
}

class _CityListState extends State<_CityList> {
  TextEditingController searchCtrl = TextEditingController();
  
  @override
  initState() {
    searchCtrl.text = widget.prefs.getString('location');
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
              hintText: 'Cari nama kota',
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.cities.length,
            itemBuilder: (context, index) {
              City city = widget.cities[index];
              
              return searchCtrl.text == null || searchCtrl.text == ''
                ? Container()
                : city.name.contains(searchCtrl.text.toUpperCase())
                ? _City(city: city, prefs: widget.prefs, searchCtrl: searchCtrl)
                : Container();
            }
          ),
        ),
      ],
    );
  }
}

class _City extends StatefulWidget {
  final City city;
  final SharedPreferences prefs;
  final TextEditingController searchCtrl;

  _City({
    Key key,
    @required this.city,
    @required this.prefs,
    @required this.searchCtrl,
  }) : super(key: key);

  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<_City> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(child: Text(widget.city.name)),
          widget.prefs.getString('location') == widget.city.name
            ? Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 18.0,
            )
            : Container()
        ],
      ),
      onTap: () {
        widget.prefs.setString('location', widget.city.name);
        widget.prefs.setInt('location_id', widget.city.id);
        setState(() => widget.searchCtrl.text = widget.city.name);
      }
    );
  }
}
