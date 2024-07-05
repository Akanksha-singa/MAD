import 'package:flutter/material.dart';
import '../android_large_two_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String androidLargeTwoScreen = '/android_large_two_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    androidLargeTwoScreen: (context) => AndroidLargeTwoScreen(),
    initialRoute: (context) => AndroidLargeTwoScreen()
  };
}
