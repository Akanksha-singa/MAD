import 'package:flutter/material.dart';
import '../android_large_one_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String androidLargeOneScreen = '/android_large_one_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    androidLargeOneScreen: (context) => AndroidLargeOneScreen(),
    initialRoute: (context) => AndroidLargeOneScreen()
  };
}
