import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFF4D4D)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your Phone Number',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildPhoneNumberInput(),
            SizedBox(height: 16),
            Text(
              'New Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildPasswordInput(_newPasswordController),
            SizedBox(height: 16),
            Text(
              'Confirm New Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildPasswordInput(_confirmPasswordController),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _changePassword();
                },
                child: Text('Change Password'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF4D4D), // Background color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return TextField(
      controller: _phoneNumberController,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Enter your phone number',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPasswordInput(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  void _changePassword() {
    String phoneNumber = _phoneNumberController.text.trim();
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (phoneNumber.isNotEmpty && newPassword.isNotEmpty && confirmPassword.isNotEmpty) {
      if (newPassword == confirmPassword) {
        // Query Firestore to find user with the given phone number
        firestore
            .collection('users')
            .where('phone_number', isEqualTo: phoneNumber)
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            // User found, update password
            querySnapshot.docs.forEach((doc) {
              String userId = doc.id; // Get the document ID
              firestore.collection('users').doc(userId).update({
                'password': newPassword,
              }).then((_) {
                // Password updated successfully, show success dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Password Changed'),
                    content: Text('Your password has been successfully changed.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop(); // Pop twice to go back to LoginScreen
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }).catchError((error) {
                print('Failed to update password: $error');
                // Handle error if necessary
              });
            });
          } else {
            // User not found with the given phone number
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
          print("Failed to find user: $error");
          // Handle error if necessary
        });
      } else {
        // Passwords do not match, show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Passwords Do Not Match'),
            content: Text('The passwords entered do not match. Please try again.'),
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
    } else {
      // Fields are empty, show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Empty Fields'),
          content: Text('Please fill in all the fields.'),
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
  }
}
