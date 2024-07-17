import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'change_pass_screen.dart'; // Import ChangePassScreen

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Instance of Firestore

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Color(0xFFFF4D4D)),
          label: Text(
            'Back',
            style: TextStyle(color: Color(0xFFFF4D4D)),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/img_group_7.svg',
                    height: 170,
                  ),
                  SizedBox(height: 0),
                  SvgPicture.asset(
                    'assets/images/img_freepik_path.svg',
                    height: 170,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Enter your password',
              style: GoogleFonts.sora(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Password',
              style: GoogleFonts.sora(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFFFF4D4D),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassScreen()), // Navigate to ChangePassScreen
                  );
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Color(0xFFFF4D4D)),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _checkPassword();
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF4D4D),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _checkPassword() {
    String enteredPassword = _passwordController.text.trim();
    if (enteredPassword.isNotEmpty) {
      firestore.collection('users').get().then((QuerySnapshot querySnapshot) {
        bool passwordMatched = false;
        querySnapshot.docs.forEach((doc) {
          String storedPassword = doc['password'];
          if (enteredPassword == storedPassword) {
            passwordMatched = true;
            return;
          }
        });

        if (passwordMatched) {
          // Password is correct, show success dialog and navigate to HomeScreen
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Login Successful'),
              content: Text('You have successfully logged in.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with actual home screen
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // Password is incorrect, show error dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Invalid Password'),
              content: Text('The password entered is incorrect.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      }).catchError((error) {
        print("Failed to check password: $error");
        // Handle error if necessary
      });
    } else {
      print("Password is empty");
    }
  }
}
