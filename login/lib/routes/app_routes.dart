import 'package:flutter/material.dart';
import '../login_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String loginScreen = '/login_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    initialRoute: (context) => LoginScreen()
  };
}
