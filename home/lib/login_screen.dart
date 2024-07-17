import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'password_screen.dart';
import 'create_account_four_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController phoneNumberController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFF4D4D), size: 18),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Back",
          style: TextStyle(color: Color(0xFFFF4D4D), fontSize: 14),
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
              child: SvgPicture.asset("assets/images/img_group_10.svg", height: 200),
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
            ElevatedButton(
              onPressed: () {
                _checkPhoneNumber(context);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CreateAccountFourScreen()),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xFFFF4D4D),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _checkPhoneNumber(BuildContext context) {
    String phoneNumber = phoneNumberController.text.trim();
    if (phoneNumber.isNotEmpty) {
      // Query Firestore to check if the phone number exists
      firestore
          .collection('users')
          .where('phone_number', isEqualTo: phoneNumber)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          // Phone number found, navigate to PasswordScreen
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PasswordScreen()),
          );
        } else {
          // Phone number not found, show pop-up dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Invalid Phone Number'),
              content: Text('The phone number entered does not exist.'),
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
        print("Failed to check phone number: $error");
        // Handle error if necessary
      });
    } else {
      print("Phone number is empty");
    }
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
            "+91",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: phoneNumberController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "0000000000",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
