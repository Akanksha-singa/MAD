import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/services.dart';
import 'settings_screen.dart';
import 'create_account_four_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'password_screen.dart';
import 'package:home/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        title: Text(
          " Back",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "PWM",
                style: TextStyle(
                  color: Color(0xFFFF4D4D),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: SvgPicture.asset(
                  "assets/images/img_group_10.svg", height: 200),
            ),
            SizedBox(height: 40),
            Text(
              "Enter your",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "mobile number",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildPhoneNumberInput(),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => CreateAccountFourScreen()),
                );
              },
              child: Text(
                "Create Account",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PasswordScreen()),
                );
              },
              child: Text("Continue"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF4D4D),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Divider(color: Colors.white)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text("or continue using",
                      style: TextStyle(color: Colors.white)),
                ),
                Expanded(child: Divider(color: Colors.white)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // _socialButton(
                //   "assets/images/img_facebook_f_logo_2019.svg",
                //       () async {
                //     // Implement Facebook sign-in logic here
                //     User? user = await authService.signInWithFacebook();
                //     if (user != null) {
                //       print('Facebook Login successful: ${user.email}');
                //     } else {
                //       print('Facebook Login failed');
                //     }
                //   },
                // ),
                _socialButton(
                  "assets/images/img_google.svg",
                      () async {
                    User? user = await authService.signInWithGoogle();
                    if (user != null) {
                      print('Google Login successful: ${user.email}');
                    } else {
                      print('Google Login failed');
                    }
                  },
                ),
                // _socialButton(
                //   "assets/images/img_path1504.svg",
                //       () async {
                //     // Implement Apple sign-in logic here
                //     User? user = await authService.signInWithApple();
                //     if (user != null) {
                //       print('Apple Login successful: ${user.email}');
                //     } else {
                //       print('Apple Login failed');
                //     }
                //   },
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Text(
            "+962",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: phoneNumberController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "7X-XXXXXXX",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialButton(String assetName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: SvgPicture.asset(
            assetName,
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
