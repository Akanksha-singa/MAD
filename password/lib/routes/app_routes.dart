import 'package:flutter/material.dart';
import '../password_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String passwordScreen = '/password_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    passwordScreen: (context) => PasswordScreen(),
    initialRoute: (context) => PasswordScreen()
  };
}
