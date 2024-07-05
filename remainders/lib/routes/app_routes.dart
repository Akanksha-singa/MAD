import 'package:flutter/material.dart';
import '../remainders_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String remaindersScreen = '/remainders_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    remaindersScreen: (context) => RemaindersScreen(),
    initialRoute: (context) => RemaindersScreen()
  };
}
