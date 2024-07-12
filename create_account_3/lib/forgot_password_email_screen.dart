import 'package:flutter/material.dart';

class ForgotPasswordEmailScreen extends StatelessWidget {
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
          // Add email input field
          ElevatedButton(
            child: Text('Send reset link'),
            onPressed: () {
              // Handle sending reset link
            },
          ),
          TextButton(
            child: Text('Use mobile instead'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/forgot_password_mobile');
            },
          ),
        ],
      ),
    );
  }
}