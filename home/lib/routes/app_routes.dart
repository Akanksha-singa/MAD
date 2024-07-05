import 'package:flutter/material.dart';
import '../home_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String homeScreen = '/home_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    homeScreen: (context) => HomeScreen(),
    initialRoute: (context) => HomeScreen()
  };
}
