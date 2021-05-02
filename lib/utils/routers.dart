import 'package:flutter/material.dart';
import 'package:masjid_tv/views/main/main_display.dart';
import 'package:masjid_tv/views/settings/iqomah.dart';
import 'package:masjid_tv/views/settings/layout.dart';
import 'package:masjid_tv/views/settings/location.dart';
import 'package:masjid_tv/views/settings/settings.dart';

class MyRouter {
  static const String main = "/main";
  static const String setting = "/setting";
  static const String layoutSetting = "/setting/layout";
  static const String locationSetting = "/setting/location";
  static const String iqomahSetting = "/setting/iqomah";

  static Map<String, WidgetBuilder> routes = {
    main : (BuildContext context) => MainDisplay(),
    setting : (BuildContext context) => SettingsView(),
    layoutSetting : (BuildContext context) => LayoutSetting(),
    locationSetting : (BuildContext context) => LocationSetting(),
    iqomahSetting : (BuildContext context) => IqomahSetting(),
  };
}
