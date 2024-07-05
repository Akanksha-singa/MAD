import 'package:flutter/material.dart';
import '../change_pass_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String changePassScreen = '/change_pass_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    changePassScreen: (context) => ChangePassScreen(),
    initialRoute: (context) => ChangePassScreen()
  };
}
