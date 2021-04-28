import 'package:flutter/material.dart';
import 'package:masjid_tv/services/ptime_service.dart';
import 'package:masjid_tv/utils/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Container(
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            return snapshot.hasData
              ? _Settings(prefs: snapshot.data)
              : Container();
          }
        )
      ),
    );
  }
}

class _Settings extends StatefulWidget {
  final SharedPreferences prefs;

  _Settings({
    Key key,
    @required this.prefs
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<_Settings> {
  bool _isFetchingData = false;
  
  Future<void> _renameDialog() async {
    TextEditingController _masjidNameCtrl = TextEditingController();
    _masjidNameCtrl.text = widget.prefs.getString('masjid_name');
    
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nama Masjid'),
          content: TextField(
            controller: _masjidNameCtrl,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                widget.prefs.setString('masjid_name', _masjidNameCtrl.text);
                Navigator.of(context).pop();
                setState(() {});
              },
            )
          ],
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _isFetchingData
        ? Container(
          color: Colors.green,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 32.0),
                Text(
                  'Mengambil data waktu sholat',
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
              ],
            )
          ),
        )
        : SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                child: ListTile(
                  title: Text('Nama Masjid'),
                  subtitle: Text(widget.prefs.getString('masjid_name')),
                ),
                onTap: () {
                  _renameDialog();
                },
              ),
              Divider(),
              InkWell(
                child: ListTile(
                  title: Text('Layout'),
                  subtitle: Text(widget.prefs.getString('layout')),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(MyRouter.layoutSetting).then(
                    (_) => setState(() {})
                  );
                },
              ),
              Divider(),
              InkWell(
                child: ListTile(
                  title: Text('Lokasi'),
                  subtitle: Text(widget.prefs.getString('location')),
                ),
                onTap: () async {
                  Navigator.of(context).pushNamed(MyRouter.locationSetting).then((_) async {
                    setState(() => _isFetchingData = true);
                    await fetchingPrayerTime();
                    setState(() => _isFetchingData = false);
                  });
                },
              ),
              Divider(),
              InkWell(
                child: ListTile(
                  title: Text('Waktu Iqomah')
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(MyRouter.iqomahSetting);
                },
              ),
            ],
          )
        ),
      ],
    );
  }
}
