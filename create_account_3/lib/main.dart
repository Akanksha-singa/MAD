import 'package:flutter/material.dart';
import 'password_screen.dart';
import 'forgot_password_email_screen.dart';
import 'forgot_password_mobile_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Reset App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PasswordScreen(),
        '/forgot_password_email': (context) => ForgotPasswordEmailScreen(),
        '/forgot_password_mobile': (context) => ForgotPasswordMobileScreen(),
      },
    );
  }
}