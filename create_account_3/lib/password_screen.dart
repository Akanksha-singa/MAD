import 'package:flutter/material.dart';

class PasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
          },
        ),
      ),
      body: Column(
        children: [
          // Add shield icon
          Text('Enter your password'),
          // Add password input field
          TextButton(
            child: Text('Forgot password?'),
            onPressed: () {
              Navigator.pushNamed(context, '/forgot_password_email');
            },
          ),
          ElevatedButton(
            child: Text('Login'),
            onPressed: () {
              // Handle login
            },
          ),
        ],
      ),
    );
  }
}