import 'package:flutter/material.dart';
import '../transfer_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String transferScreen = '/transfer_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    transferScreen: (context) => TransferScreen(),
    initialRoute: (context) => TransferScreen()
  };
}
