import 'package:flutter/material.dart';
import '../change_pass_confirm_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String changePassConfirmScreen = '/change_pass_confirm_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    changePassConfirmScreen: (context) => ChangePassConfirmScreen(),
    initialRoute: (context) => ChangePassConfirmScreen()
  };
}
