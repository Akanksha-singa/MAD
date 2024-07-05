import 'package:flutter/material.dart';
import '../transfer_to_two_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String transferToTwoScreen = '/transfer_to_two_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    transferToTwoScreen: (context) => TransferToTwoScreen(),
    initialRoute: (context) => TransferToTwoScreen()
  };
}
