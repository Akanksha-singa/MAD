import 'package:flutter/material.dart';
import '../create_account_four_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String createAccountFourScreen = '/create_account_four_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    createAccountFourScreen: (context) => CreateAccountFourScreen(),
    initialRoute: (context) => CreateAccountFourScreen()
  };
}
