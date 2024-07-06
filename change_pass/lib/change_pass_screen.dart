import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassScreen extends StatefulWidget {
  ChangePassScreen({Key? key}) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Change password",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            _buildPasswordField(
              "Type your new password",
              newPasswordController,
              _obscureNewPassword,
                  () {
                setState(() {
                  _obscureNewPassword =!_obscureNewPassword;
                });
              },
            ),
            SizedBox(height: 20),
            _buildPasswordField(
              "Confirm password",
              confirmPasswordController,
              _obscureConfirmPassword,
                  () {
                setState(() {
                  _obscureConfirmPassword =!_obscureConfirmPassword;
                });
              },
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xFFFF4D4D)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                onPressed: () {
                  // Handle password change
                },
                child: Text(
                  "Change password",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscureText, VoidCallback onToggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: GoogleFonts.poppins(color: Colors.white),
          decoration: InputDecoration(
            hintText: "••••••••••••",
            hintStyle: GoogleFonts.poppins(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText? Icons.visibility_off : Icons.visibility,
                color: Colors.white,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }
}