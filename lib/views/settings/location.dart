import 'package:flutter/material.dart';
import 'package:masjid_tv/models/location_model.dart';
import 'package:masjid_tv/services/location_service.dart';
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
          future: Future.wait([getLocationList(), SharedPreferences.getInstance()]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error)
              );
            }
  
            return snapshot.hasData
              ? _LocationList(locations: snapshot.data[0], prefs: snapshot.data[1])
              : Center(child: CircularProgressIndicator());
          }
        )
      )
    );
  }
}

class _LocationList extends StatefulWidget {
  final List<Location> locations;
  final SharedPreferences prefs;
  
  _LocationList({
    Key key,
    @required this.locations,
    @required this.prefs
  }) : super(key: key);
  
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<_LocationList> {
  TextEditingController _searchCtrl = TextEditingController();
  String _filter;
  
  @override
  initState() {
    _searchCtrl.text = widget.prefs.getString('location');
    _filter = _searchCtrl.text;

    _searchCtrl.addListener(() {
      setState(() {
        _filter = _searchCtrl.text;
      });
    });
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              hintText: 'Cari nama kota',
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.locations.length,
            itemBuilder: (context, index) {
              Location location = widget.locations[index];
              
              return _filter == null || _filter == ''
                ? Container()
                : location.name.contains(_searchCtrl.text.toUpperCase())
                ? _Location(location: location, prefs: widget.prefs, searchCtrl: _searchCtrl)
                : Container();
            }
          ),
        ),
      ],
    );
  }
}

class _Location extends StatefulWidget {
  final Location location;
  final SharedPreferences prefs;
  final TextEditingController searchCtrl;

  _Location({
    Key key,
    @required this.location,
    @required this.prefs,
    @required this.searchCtrl,
  }) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<_Location> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(child: Text(widget.location.name)),
          widget.prefs.getString('location') == widget.location.name
            ? Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 18.0,
            )
            : Container()
        ],
      ),
      onTap: () {
        widget.prefs.setString('location', widget.location.name);
        widget.prefs.setInt('location_id', widget.location.id);
        setState(() => widget.searchCtrl.text = widget.location.name);
      }
    );
  }
}
