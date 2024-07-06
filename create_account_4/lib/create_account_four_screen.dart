import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFF4D4D)),
          onPressed: () => Navigator.of(context).pop(),
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
            _buildTextField('Email', 'e.g. email@example.com', emailController),
            SizedBox(height: 16),
            _buildPasswordField(),
            SizedBox(height: 20),
            _buildTermsAndConditions(),
            SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color(0xFFFF4D4D)),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text('Create a new account'),
            ),
            SizedBox(height: 20),
            _buildDivider(),
            SizedBox(height: 20),
            _buildSocialLogin(),
          ],
        ),
      ),
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
                color:Color(0xFFFF4D4D),
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
          fillColor: WidgetStateProperty.resolveWith((states) => Colors.white),
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

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue using',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Expanded(child: Divider(color:Colors.white)),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _socialButton('assets/images/img_facebook_f_logo_2019.svg'),
        _socialButton('assets/images/img_google.svg'),
        _socialButton('assets/images/img_path1504.svg'),
      ],
    );
  }

  Widget _socialButton(String assetName) {
    return Container(
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
    );
  }
}