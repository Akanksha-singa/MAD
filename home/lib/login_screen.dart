import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'firebase/auth_service.dart';
import 'home_screen.dart'; // Import the HomeScreen widget
=======
import 'package:flutter_svg/flutter_svg.dart';
import 'settings_screen.dart';
import 'create_account_four_screen.dart';
import 'password_screen.dart';
import 'package:home/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
>>>>>>> fa9063109f408205325be69ede22e87d945a61d6

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

<<<<<<< HEAD
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final user = await _authService.signInWithGoogle();
      print('Logged in successfully: $user');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print('Failed to log in: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to log in: $e'),
      ));
    }
  }
=======
  final TextEditingController phoneNumberController = TextEditingController();
  final AuthService authService = AuthService();
>>>>>>> fa9063109f408205325be69ede22e87d945a61d6

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialButton(
                  "assets/images/img_google.svg",
                      () async {
                    User? user = await authService.signInWithGoogle();
                    if (user != null) {
                      print('Google Login successful: ${user.email}');
                      // Navigate to the home screen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      print('Google Login failed');
                      // Show an error message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Google Sign-In failed. Please try again.')),
                      );
                    }
                  },
                ),
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