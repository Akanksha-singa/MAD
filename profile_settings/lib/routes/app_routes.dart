import 'package:flutter/material.dart';
import '../profile_settings_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String profileSettingsScreen = '/profile_settings_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    profileSettingsScreen: (context) => ProfileSettingsScreen(),
    initialRoute: (context) => ProfileSettingsScreen()
  };
}
