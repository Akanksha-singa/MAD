import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home/home_screen.dart';
import 'login_screen.dart'; // Add this import

class CreateAccountFourScreen extends StatefulWidget {
  @override
  _CreateAccountFourScreenState createState() => _CreateAccountFourScreenState();
}

class _CreateAccountFourScreenState extends State<CreateAccountFourScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool termsAndConditions = false;
  bool _obscureText = true;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFF4D4D)),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
        title: Text(
          'Back',
          style: TextStyle(color: Color(0xFFFF4D4D), fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildTextField('Name', 'e.g. John Doe', nameController),
            SizedBox(height: 16),
            _buildTextField('Phone Number', 'e.g. 8989898989', emailController),
            SizedBox(height: 16),
            _buildPasswordField(),
            SizedBox(height: 20),
            _buildTermsAndConditions(),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF4D4D),
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _createAccount,
              child: Text('Create a new account'),
            ),
            SizedBox(height: 20),
            // _buildDivider(),
            SizedBox(height: 20),
            // _buildSocialLogin(),
          ],
        ),
      ),
    );
  }

  void _createAccount() {
    String name = nameController.text.trim();
    String phoneNumber = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isNotEmpty && phoneNumber.isNotEmpty && password.isNotEmpty && termsAndConditions) {
      // Add user data to Firestore
      firestore.collection('users').doc(phoneNumber).set({
        'name': name,
        'phone_number': phoneNumber,
        'password': password,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
        print("User data added to Firestore");
        showSuccessDialog(); // Show success dialog on successful account creation
      }).catchError((error) {
        print("Failed to add user data: $error");
      });
    } else {
      // Handle case where form data is incomplete or terms are not accepted
      print("Please fill in all fields and accept terms and conditions.");
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Account Creation Successful"),
          content: Text("Your account has been created successfully."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                ); // Navigate back to login screen
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        SizedBox(height: 8),
        TextField(
          controller: passwordController,
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
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: termsAndConditions,
          onChanged: (value) {
            setState(() {
              termsAndConditions = value!;
            });
          },
          fillColor: MaterialStateProperty.resolveWith((states) => Color(0xFFFF4D4D)),
          checkColor: Colors.black,
        ),
        Expanded(
          child: Text(
            'I accept terms and conditions and privacy policy',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
