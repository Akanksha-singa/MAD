import 'package:flutter/material.dart';
import '../transfer_to_one_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String transferToOneScreen = '/transfer_to_one_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    transferToOneScreen: (context) => TransferToOneScreen(),
    initialRoute: (context) => TransferToOneScreen()
  };
}
