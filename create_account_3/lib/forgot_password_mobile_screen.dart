import 'package:flutter/material.dart';

class ForgotPasswordMobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        actions: [
          TextButton(
            child: Text('Done'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text('Forgot your password?'),
          // Add country code and phone number input fields
          ElevatedButton(
            child: Text('Send reset link'),
            onPressed: () {
              // Handle sending reset link
            },
          ),
          TextButton(
            child: Text('Use email instead'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/forgot_password_email');
            },
          ),
        ],
      ),
    );
  }
}