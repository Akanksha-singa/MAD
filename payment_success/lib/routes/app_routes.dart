import 'package:flutter/material.dart';
import '../payment_success_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String paymentSuccessScreen = '/payment_success_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    paymentSuccessScreen: (context) => PaymentSuccessScreen(),
    initialRoute: (context) => PaymentSuccessScreen()
  };
}
