// profile_settings.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'change_pass_screen.dart';
import 'home_screen.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF4D4D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          ),
        ),
        title: Text(
          'Profile Settings',
          style: GoogleFonts.sora(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Text(
                'R',
                style: GoogleFonts.roboto(
                  fontSize: 46,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4CBB9B),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Rex Kyojuro',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    _buildProfileItem(context, 'Full name', 'Rex Kyojuro', 'img_user_6_line'),
                    _buildProfileItem(context, 'Mobile', '+91 98769543210', 'img_smartphone_line'),
                    _buildProfileItem(context, 'Email', 'rex@gmail.com', 'img_mail_open_line'),
                    _buildProfileItem(context, 'Change password', '', 'img_lock_2_line', showArrow: true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, String title, String value, String iconName, {bool showArrow = false}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (showArrow) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePassScreen()),
              );
            }
          },
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4D4D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  'assets/images/$iconName.svg',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      value,
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (showArrow)
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16)
              else
                Text(
                  'Edit',
                  style: GoogleFonts.sora(
                    color: Color(0xFFE77676),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Divider(color: Colors.white, height: 1),
        SizedBox(height: 16),
      ],
    );
  }
}
