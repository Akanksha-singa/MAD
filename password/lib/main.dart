import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'password_screen.dart';
// import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   textTheme: GoogleFonts.soraTextTheme(Theme.of(context).textTheme),
      // ),
      home: PasswordScreen(),
    );
  }
}