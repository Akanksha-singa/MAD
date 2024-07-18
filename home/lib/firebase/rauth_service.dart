import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLogin = true;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_isLogin) {
          await _auth.signInWithEmailAndPassword(email: _email, password: _password);
        } else {
          await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        }
        Navigator.of(context).pushReplacementNamed('/remainders');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF4D4D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF4D4D)),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
                  onSaved: (value) => _email = value!,
                ),
                SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF4D4D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF4D4D)),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) => value!.length < 6 ? 'Password must be at least 6 characters' : null,
                  onSaved: (value) => _password = value!,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(_isLogin ? 'Login' : 'Sign Up'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF4D4D),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _submitForm,
                ),
                TextButton(
                  child: Text(_isLogin ? 'Create an account' : 'I already have an account'),
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFFFF4D4D),
                  ),
                  onPressed: () => setState(() => _isLogin = !_isLogin),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}