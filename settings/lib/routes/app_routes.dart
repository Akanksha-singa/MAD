import 'package:flutter/material.dart';
import '../settings_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String settingsScreen = '/settings_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    settingsScreen: (context) => SettingsScreen(),
    initialRoute: (context) => SettingsScreen()
  };
}
