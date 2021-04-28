import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IqomahSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waktu Iqomah'),
      ),
      body: Container(
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            return snapshot.hasData
              ? Column(
                children: [
                  _IqomahSettingWidget(text: 'Subuh', prefs: snapshot.data),
                  Divider(),
                  _IqomahSettingWidget(text: 'Dzuhur', prefs: snapshot.data),
                  Divider(),
                  _IqomahSettingWidget(text: 'Ashar', prefs: snapshot.data),
                  Divider(),
                  _IqomahSettingWidget(text: 'Maghrib', prefs: snapshot.data),
                  Divider(),
                  _IqomahSettingWidget(text: 'Isya', prefs: snapshot.data),
                  Divider()
                ],
              )
              : Container();
          }
        )
      )
    );
  }
}

class _IqomahSettingWidget extends StatefulWidget {
  final String text;
  final SharedPreferences prefs;

  _IqomahSettingWidget({
    Key key,
    @required this.text,
    @required this.prefs
  }) : super(key: key);
  
  @override
  _IqomahSettingWidgetState createState() => _IqomahSettingWidgetState();
}

class _IqomahSettingWidgetState extends State<_IqomahSettingWidget> {
  @override
  Widget build(BuildContext context) {
    final _prefName = 'iqomah_' + widget.text.toLowerCase();
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(widget.text)
          ),
          Expanded(
            child: Row(
              children: [
                ElevatedButton(
                  child: Text('-'),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder()
                  ),
                  onPressed: () {
                    if (widget.prefs.getInt(_prefName) > 0) {
                      widget.prefs.setInt(_prefName, widget.prefs.getInt(_prefName) - 1);
                      setState(() {});
                    }
                  }
                ),
                SizedBox(
                  width: 32.0,
                  child: Center(
                    child: Text(
                      widget.prefs.getInt(_prefName).toString()
                    )
                  )
                ),
                ElevatedButton(
                  child: Text('+'),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder()
                  ),
                  onPressed: () {
                    widget.prefs.setInt(_prefName, widget.prefs.getInt(_prefName) + 1);
                    setState(() {});
                  }
                ),
                SizedBox(width: 16.0),
                Text('Menit'),
              ],
            )
          ),
        ],
      ),
    );
  }
}
