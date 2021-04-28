import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LayoutSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout'),
      ),
      body: Container(
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            return snapshot.hasData
              ? _LayoutSetting(prefs: snapshot.data)
              : Container();
          }
        )
      ),
    );
  }
}

class _LayoutSetting extends StatefulWidget {
  final SharedPreferences prefs;

  _LayoutSetting({
    Key key,
    @required this.prefs
  }) : super(key: key);
  
  @override
  _LayoutSettingState createState() => _LayoutSettingState();
}

class _LayoutSettingState extends State<_LayoutSetting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image(image: AssetImage('assets/layout_landscape.png')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'Landscape',
                        groupValue: widget.prefs.getString('layout'),
                        onChanged: (value) {
                          widget.prefs.setString('layout', value);
                          setState(() {});
                        },
                      ),
                      Text('Landscape'),
                    ],
                  )
                ],
              ),
            )
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image(image: AssetImage('assets/layout_portrait.png')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'Portrait',
                        groupValue: widget.prefs.getString('layout'),
                        onChanged: (value) {
                          widget.prefs.setString('layout', value);
                          setState(() {});
                        },
                      ),
                      Text('Portrait'),
                    ],
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
