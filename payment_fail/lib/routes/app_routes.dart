import 'package:flutter/material.dart';
import '../payment_fail_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String paymentFailScreen = '/payment_fail_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    paymentFailScreen: (context) => PaymentFailScreen(),
    initialRoute: (context) => PaymentFailScreen()
  };
}
